Return-Path: <stable+bounces-210309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D30D3A656
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F930300C359
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72303596F0;
	Mon, 19 Jan 2026 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="BdU15EKU"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59A3090E4;
	Mon, 19 Jan 2026 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820910; cv=fail; b=kwFKeBPdliiq8jlKpc2Ffccn4EOOk97FxHfqmoJcN0gExWqVKQzZhDlJieLW3E+g6WeNCQ2HtOXxSDn0LIoNlECOCJ862Zar2vJvhx1cr56gptq4SaAGolrip8O5uDRhDsiL8eUB3gLsL3eVMPEdi7jArG1f/6unQnUFXs1fMHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820910; c=relaxed/simple;
	bh=LdxVFykcRMN5Dnj1ncKqD4sLGFckbmFHpTRJdzWwgD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fhm3Izq2F/0HCg+k40bQbJzJOhoi6bNNwEvMc8egzikVfJ4CQ5mybQrK/CX/n72yMHsxLzb/UzWQcqlg8M/DR5kwD8yQK5eKrpd7MRMWuI/1Jz9eIKJMdRdA7Xb75k68MERv3sYMlBAi0eB/MfxpcGp3skfSeApKA0ytr5QhZ+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=BdU15EKU; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syRoiBINlP5PppvnB/Nhy52mGqOYF5jSXnS1Z13FCIExXur/UrlLEaQejHwDd4/b365HMa1r/tTJuoAPE9KF+/Zx8Mr/3VB/IHA5SC2UrBtgoCO578F1Wk7Tpi2fBD0rTsjWhjr0+ENpRYXa5mHZotAZ8Bm26UvdmjTDyRgodxf4tZWC8XbfFJTd9/Mh0Ygqzy73EPvi0nc6ns7vLOyjrZSJ0W84bkQjV1HoUUufpZomC/NYPmY8X5RHb174dPmVPteb7V8x84e5rvCRKyL1uc2KWGtL/DhQYXjTRuAWaGk8n4Y1Qtz1nFtY59kuT2W43HOUjFATPUi0+5+CkmItIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukbMloSg5ObAglPJXSYWVO9cXzkdEI7TThDFye5cjG8=;
 b=tHJEw0Tu+7rhoPRRDW7z//wbjA3s/lETLVhWP48hm7Bk2327CQ+p3q8/BS73KaP+E+6uMWTvR3+BRH8cUs2n+P7cWYUQi2hMugPFstSG4bZ18TOG0UTddg1HNmYN/VTi2zutrlgEc5isyJJJVXq/sV94+NCUPVidHt1FV4VU2AH9OBxRzgSbN3MxtEA0YVkJdj8TOgdvnlQMpaoc1nHODlV7dRSHMMUVBGxVc2bS02MqFXNVVyn/RZYQOkUhHSJHodLGQK1Z4moNCVGcYCb8OrcH/FF/2amwom37xUFhOOWeIYUwDb4dgUSXjMEfUOCtKp4uZ6obheOkNnVuDeu6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukbMloSg5ObAglPJXSYWVO9cXzkdEI7TThDFye5cjG8=;
 b=BdU15EKUK1ie/xprap51kqWhCeAT/ltRrODGN3pqYL8KLesHJkxkc8k7sFAUQv8MGpU7+9XgTWVM8oU2ZR15cNKoSgMMApBUK/Rca4JbkvQhXxc2NHRJu06Oxph/JzGfLQ771NEI8vsUlomdnebveT0QjolxxpCQzEXhVe8+nHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8372.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Mon, 19 Jan
 2026 11:08:23 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 11:08:22 +0000
Message-ID: <b0904cb5-3659-41cc-8395-79eec9e82f01@cherry.de>
Date: Mon, 19 Jan 2026 12:08:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on
 RK3576
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 892a193d-357f-4a72-8868-08de574b0f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVEyN280bUxlQVJuWTRQVnZGRm04ZENpK0xkZjJybTZuVU4xOXR2TFFibEtp?=
 =?utf-8?B?VDM3UHRJSnVDTFl1dnlybFdQTTN2eld6WkF4S1RwNXpJS3ppSVZtMzJGcU9n?=
 =?utf-8?B?T2huSEZtVU5KaStRaHBsVW54L0pCczAxWHkveDNVeEdJRGg4ekh6V1lueWdT?=
 =?utf-8?B?VjEySVJDSzUrVVBxT2F5SE9qTFhQY0s5NEpuMlVLNzBlNzNBWDFFa2cxOGZN?=
 =?utf-8?B?VDVnOCs0T0drcWZHNDBVdkFON1RIU3NRNUhxbXVvSFk0S0lseVZ1YnJWSDV2?=
 =?utf-8?B?RkNqNE4zS2luRzI3MHNQajV6cDY3eCt6MTNEYnhPOFg4eUUwSlNkSVUvWWNW?=
 =?utf-8?B?NHlicjVSem1kc0swQm1VRXZXZFc0dS9UalBkT3pRZE5VL3RDRnhWSWV6Uk5H?=
 =?utf-8?B?Y05mMTkwd0x3b2JIYW1yMnV0MUZMc0NwbUlUdEZSVmxJbFdDeW9sZGdiRWpL?=
 =?utf-8?B?a2QvSUdFbjFkYTlBMytPa3cvdWphd0NJek1yZ2RVenhoWG1COVFBMEFzdU1X?=
 =?utf-8?B?NHRvazVIcVhHK2NmYlZUbXhtY25mNm9yVWVzUVJNamZ6LzN5SDQ2TnliNWhN?=
 =?utf-8?B?UUVIbFo3SWc4N0tYU3BMTDNSdjZwRUhBZ0ZldkYxN2JocFcrcnJIVWluNWZY?=
 =?utf-8?B?NENObjQvRWJabmZOQmowcEY0eWtCTXBDZzRybWVXMkZ2RnJPc1FnTExFQlY2?=
 =?utf-8?B?Ni9DY2hvcmdZWFZ4STBPQ2ZWcTJqT053V0toemsvVExoeE1jRnpsYy8vUnVl?=
 =?utf-8?B?N251TFZzNmU3TWFqZXVBYWt3VDZCdHVsVmxDdlZYNUZONDhVTmtjUjg5ZkJ0?=
 =?utf-8?B?dzcvUUhvcURYVXRXUnNXeWxJQWNaVEdHbDlYQ0MyM05EL01jTHBJNkZ3WC90?=
 =?utf-8?B?SldDZXNHOUxpOUlsVURFK2tYSFBva29qSzJNU0RWS00zWkZTeWYxc0xCODlJ?=
 =?utf-8?B?UVBDaXIzc29GZytpbVNHQWcyODNGTTd3VHZyWTU4d3NsY2RxV2o2NjZ1eDVE?=
 =?utf-8?B?MnNTSHBDNGdjRVZCcHB2eXREYU5XN1V2QnJ4RDJYRzc3NWZoVFdVY2d5cWUw?=
 =?utf-8?B?RVZzSFN3NFRzYmloMDZOSFJiY3lBTWpKWHluU0VQOGpuelAvV1ZVaTFnYWRL?=
 =?utf-8?B?VDJPNXhaaUdUTUJyc01Gd3Y5THBrWnBwSGU1SldoYzBGZEFQSVNBRWM1SVRG?=
 =?utf-8?B?cWx6N1RpemttTXZvRTlGWTVtTTNKTWE5eDgwMHd5bi9rQ3BxQlZZMVlLa0Ry?=
 =?utf-8?B?Sk5YalZGVHBRbHY3WlBRUGRoUDY3RHJLcytoY0lKcTQzc2tTQi84bXFudUI2?=
 =?utf-8?B?VHpjaGJHRVo4amUxbUhPT01vVG5XTUdqaHdHUzNBeHdJc1U0ZzdWdytzSEE0?=
 =?utf-8?B?SnZwRFhuc25tYkFlL3FKd0t1VGN0WWMxWGorZnNlRitYZ3hPU3lSQmt0Z09B?=
 =?utf-8?B?L3piY00vWnVjWjRiVU5aUnFBZUNkWEhVSHpucDhSa21xVXZmZ1FLUFhjTFBL?=
 =?utf-8?B?UEQ1bFRqNTZoTnkrK1hxVlJCdndsUHZMQmRvZU4zTGFJZmZpeWVhUEZ1cFI1?=
 =?utf-8?B?aVBORFBCMCtQbHI3TCtKNWltLyszS3JubHErVTJRSTM5bWZlVjJtNHZsZTEv?=
 =?utf-8?B?ZENhditkeU4yNEUwcUl0K3F3VHRQbXRUeVNVNHFDYzgzUFZKQXVnU2dIajhZ?=
 =?utf-8?B?N0phTlYxQWVzdWpRTGNvN3FvNjIrbVVkQmZrWjB2bXMyQlBJRUdmUUJFRnFD?=
 =?utf-8?B?MkxsejY2S0lMQ1hrbEhFTFpMa2dpbVZQZEJxaHQ3WUl1bUlQM0FQWGJ2QWlo?=
 =?utf-8?B?dDd0Y2wzYUh0MXNLb3lhdGJGZ1pUVEJ2QWU3RHRtdnN3aU5Rcnk3bHJnOC9I?=
 =?utf-8?B?WHJkYTVCV1g4dEtyamtRVFhqU3MrZnV3MllvanA1YzZHR0R1M3BGemRDd2pm?=
 =?utf-8?B?YjlRRlEyVGZIS3NubHBLZ0pqRERPMkpKWWxYUGNZazdQUDV6OG84S0YxWkFt?=
 =?utf-8?B?USt5Z1dmRFVtNnBJeDZvRUp0T3pUOHJEVUtnd3ZlQlRwbnR0K084Z3ExdWtY?=
 =?utf-8?B?QnRBRTBjbmRtOFl2aUcvSTdIcnFVd3I1MU1Sd2ZZbllUTWhHYkZ2M215NmJO?=
 =?utf-8?Q?YJgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUs1WW1vMFppSVZVRk8zQ2tjMFIxQ1hVNmx3em4rbkY5dzlHcDROZEpscUpC?=
 =?utf-8?B?UGlYR2tFNjdVdkgxdXFOTXE3MDl6Uzh5bktLR2R1WmVtSVh5VjZ6OWgyMkN3?=
 =?utf-8?B?eis2ODEyRE5tMDFtUDdOOTFlRFpXQWJPRmdEZ2RXUlMrbXpWdS81VUdKTDlr?=
 =?utf-8?B?NmdRMWJDZy9NNmFTdVUvOXlMcFVreHQzb0xCVkt0QnlBdFR3OTNhZTdiNElr?=
 =?utf-8?B?MWE2c0s5bU02RVBvalJiemZTeDM3d21qSG5PSVIxbjE1NEV3K0drM1VRVnpY?=
 =?utf-8?B?d2tLMjYwUi9zUGdhN0xKMzJLWHlRWWxZKzhqajFDUG9VNW0rS21LMFo0VHBE?=
 =?utf-8?B?eEhQQk1LK3BKSnFwOE9JRzhla2xyejg3Y0xwMlpmZnJpZUkwREJuVVd6Snps?=
 =?utf-8?B?YU02SlJBbjlvV1VVQTJvTUovNVJPajhONTViWi9mTVphQnhOeUM4WmFpNnV5?=
 =?utf-8?B?TkVWOXpNMStTdlh0a0FXRVNMYm9oN3dLZWVoQzE1NHN2RUVOaUZYZ1lsM0Rs?=
 =?utf-8?B?d3NQbnRWenQ1K2NHREhCZDhTdjJLQitwUnVFNHhBOTc4S2tIV0NDN3Zvb1Bk?=
 =?utf-8?B?cXMvTlhTblM2cm5JVmpWaHB4aW1QbEJ4MzUvdnJyZGV0YVAwdTZWcEFvLytY?=
 =?utf-8?B?QWZKTWttbUViY2hSVVpJSDkrK3NrUTV6ekRGNHgrekpjUHpZSWs4Wi9UME1s?=
 =?utf-8?B?VXRYd0NCYUEveWFkWVg5Tm9pQ0tTMWJuTGZrb0pOVjlReWxqOERKWU9oeVFk?=
 =?utf-8?B?T2YyNndTem9PY2l4NlhwMy9QbnhxRjhJRi9rVzNHUC80UERNVU1xMGxUZXUx?=
 =?utf-8?B?QzBEci9xWjk5RTg4L3QvWEdMM1VoVmp5Vy9iZW1zZ0Q3R3hLRkk0MURhNUxG?=
 =?utf-8?B?c2JmWVV2SEhkNjMyYk1TY0hsNmJ5cUN2dGlmQlVtT3NiZ3pvNmlJVEh6UUdQ?=
 =?utf-8?B?RlozK1lqeDV0R1BjdmpHZ2d4MkRIQWw4Q3hzUEp6R1ZldWNMem5WYk9LdXdO?=
 =?utf-8?B?Z1J1b2RpQWd6NVJ2M1R1cDJiYkptUmwzTm1vZ3lydHJEajRzc2I2Rll4Zjk5?=
 =?utf-8?B?bldJaGJpSm9abVpuQ0YzNVdlZStIUEhRWXBtUnFQNXYwM3hIN0Nna2ZwVFo3?=
 =?utf-8?B?aGliVHFjVlAvUkowalBqNmdKRFJGNmNTU3YwNC9sZW9lUlYxQjVvMmhaN2N3?=
 =?utf-8?B?eUkwbTJ2NzdINmFDTXdLd1ZCWEE0UGR0dVpscTdqcERlSkZ1UjREU3FHckdm?=
 =?utf-8?B?SWtpc0RDQS9hakEzZWNDTEU0K3ovbE92ZExqMDQvc3dYM0FsMW83MmZ4MERn?=
 =?utf-8?B?b0U1eFJQT2V1ZXJjbE9raW9VRGExZlJITHZSc01mNlgwY1doOGNXTHdEaWpq?=
 =?utf-8?B?ZVVoS0hOL1ArOHl4Q1hvOGU3OHV5anN0Rm9UeWsyZkJQMmtYSXEwK3JSMVpt?=
 =?utf-8?B?WWpseUY2YTA3bnh1djV0RjZRMVhXTEtFY1dxZUxleGF4aEVLTTI0aVVqamZs?=
 =?utf-8?B?QkFQNkRuN3pkdmVuWm9lbDVRQmpZWHl0LzZyRFU3Uk5RcE1wN1ZoaUVlZXpi?=
 =?utf-8?B?Z1dRZmsvY29jcmljc1dFS2tjMXliQVArQUpObTNyN3BRcWpBRmZHS3BwbDhl?=
 =?utf-8?B?ZGhQYk4yYWoyL01ib25aZzdUZlZWVE5xcUl5VmlFSXFtaVo3UkFXMysxWVM0?=
 =?utf-8?B?TzBBd0JhREdRVVdMQk5FbmxwZGIrWGFKRS93aFJEVmpRQTdNWWlYSnBMNkpp?=
 =?utf-8?B?TXFMem1aaDhCb3prRG5qQXlKaUZ6dDZFeDYrd00vd2daUWo5ZWlkYkFZOFFH?=
 =?utf-8?B?UTVRZGVPVzYwOXJpM3o2ZEZKa0hUb1NweU92TDB0dVdoZ2hFb1loVTdid1RK?=
 =?utf-8?B?THNuUkVLL1hHTnhmWUk3WHFUdTd5dllNU1FhY1VzM2lFZWVBeDg3aUlIK1Nq?=
 =?utf-8?B?L1lCcmRqYUpSTjlBdjJNTWl0S3YvQnZlR0JJekpWVDd2eGg1RkhHU3QzUG0z?=
 =?utf-8?B?aWt4SVNxVG1McTRObm5sNkJKVTBJd1gwRkJudkE3MnRKNnZjOGIrQVVrelJw?=
 =?utf-8?B?ZkJ6bnZ2N0dzTWZzYllDRUlDKzVZTm1MVWwyMVl4U3NSc2JaYkJMU2VJTTE5?=
 =?utf-8?B?ajlHaTFtcmRqWnFDR2RKaFBlTlU4M0ZUSnpEei9jMkZjRzg4RWEyUE9VSk50?=
 =?utf-8?B?Y3JMc0VvcnRqN2svOW5kR1JHcVRrZG1iNFdMekZ0b2E4eElFaHE0d1JBaHNK?=
 =?utf-8?B?QmxJK3c4QVZpdDVYalIyRVBDamovaXhyNWF4WnBMNVpEVFdPL2VONmgxVjFZ?=
 =?utf-8?B?emNZQWxyYzFrVFVWTDkyendBM0FjMThlYzdnNW9jMW5vZjZpV3RBaGpTSkRZ?=
 =?utf-8?Q?bJKgq2sCENe3m2eNAlj5C21JO8f2GQJmPts36?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 892a193d-357f-4a72-8868-08de574b0f8a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:08:22.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyDThZVZyZUg3lXlgO99yoygrxVGBgmiVKfzR4E7tRh9NbPuR7A+yPKgW7C4NMxrqU21NBMlLZJAEoRxgFEXAdSa3qvjG3FrqOZvTYsysFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8372

Hi Alexey,

On 1/19/26 10:22 AM, Alexey Charkov wrote:
> Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
> UFS device, which can operate either in a hardware controlled mode or as a
> GPIO pin.
> 
> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> hardware controlled mode if it uses UFS to load the next boot stage.
> 
> Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> device reset, request the required pin config explicitly.
> 
> This doesn't appear to affect Linux, but it does affect U-boot:
> 
> Before:
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> < ... snip ... >
> => ufs init
> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> 
> After:
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> < ... snip ...>
> => ufs init
> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
> => md.l 0x2604b398
> 2604b398: 00000010 00000000 00000000 00000000  ................
> 
> (0x2604b398 is the respective pin mux register, with its BIT0 driving the
> mode of UFS_RST: unset = GPIO, set = hardware controlled UFS_RST)
> 
> This helps ensure that GPIO-driven device reset actually fires when the
> system requests it, not when whatever black box magic inside the UFSHC
> decides to reset the flash chip.
> 
> Cc: stable@vger.kernel.org
> Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for RK3576 SoC")
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> This has originally surfaced during the review of UFS patches for U-boot
> at [1], where it was found that the UFS reset line is not requested to be
> configured as GPIO but used as such. This leads in some cases to the UFS
> driver appearing to control device resets, while in fact it is the
> internal controller logic that drives the reset line (perhaps in
> unexpected ways).
> 
> Thanks Quentin Schulz for spotting this issue.
> 
> [1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de/
> ---
>   arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
>   arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> index 0b0851a7e4ea..20cfd3393a75 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> @@ -5228,6 +5228,13 @@ ufs_rst: ufs-rst {
>   				/* ufs_rstn */
>   				<4 RK_PD0 1 &pcfg_pull_none>;
>   		};
> +
> +		/omit-if-no-ref/
> +		ufs_rst_gpio: ufs-rst-gpio {
> +			rockchip,pins =
> +				/* ufs_rstn */
> +				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;

The SoC default is pull-down according to the TRM. Can you check please? 
For example, the Rock 4D doesn't seem to have a hardware pull-up or 
pull-down on the line and the UFS module only seems to have a debouncer 
(capacitor between the line and ground). So except if the chip itself 
has a PU/PD, this may be an issue?

Cheers,
Quentin

