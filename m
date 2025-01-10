Return-Path: <stable+bounces-108170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13015A08903
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 08:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A165166531
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF1B206F2E;
	Fri, 10 Jan 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DjGR9iG9"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2094.outbound.protection.outlook.com [40.92.63.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6142066F6;
	Fri, 10 Jan 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494642; cv=fail; b=Gs+GDLr9xE5dOwk8VI/9iW6vB/kjeVk2cVSBWesx92RzAu+HviVJLZ9ks0scKYljyy9en8211RwDbnGXg2IychHdvqj3Vamzf0lXNZrNePaubBJ1245JluOoTFSiUHIVblxbJES8vWIaHSU/720KSg42qFEyZ21vOzZgtAMCHc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494642; c=relaxed/simple;
	bh=clVHHS/da1TH97y9Ae3IAWOciL0fUcb/WLh64X38Nao=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mL28qm4Z6p+LuexbBGelIYti5Jarrfs3tCuvNBGpznwMPdPbOTC4hUd2RfZxnCMkFTzL0slsxgXOoKhi7qBZyuP/UdUuU9wHB1yL59pC/0Uz6AfLpeUBrzLYTKDCFm4WpuuwO3F3qqN8SmxKySdy5SXHDkRuJ2oh4SSismi7v2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DjGR9iG9; arc=fail smtp.client-ip=40.92.63.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWxeiyZeNXaWZ6kTxVnJMEW5A0ax55NiJyRr1vMvyvcHcLJQ/kCKZlTHh0gE/UC8dWp3NsjH3XcrhdVSblLs6/z9e8PvAZYUE/hS5LsAb8Hw356KFrgrhGsDrsmXfjBs7tZFhUi88k8EBxhsoD58fXwvGpynsdDZ1rTTFZ1jOf1MjbTNPtuHI6M6T4qwK33h18LGV5uH5mSxWGTrTZxLsJrFNHDzNfJTktpTZ4jR1ZMvzkLWCA75Mr8QuJO24zs7RZfVqWDxQZS1dgba7+UuqoO8XBRx/GFERk3p1bbHTBEzR5uUDI+m+bJ721yCJWn7ytfnil26GhE/7ywxgiF3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brhnO1tbDTL0TKBNilKhkbxPI9QKKJKsEH9K79R84ow=;
 b=W1yxownEuPdMpQtmmMVtDSDWr5bzxJpdGA0ghUHH9IoFQsWaZbQC8bTJfhmqZQU1OaDSp6YGIOs2X/n5Xa7ns0eXmLZPfQd4HaXLL05WTGfAyzqYLtOEtq7TPl2uO8MudOkkqEmfZCxV5/OBu3mwXb0Gp2Oc5N80HNNHq0W9AL/Se5jrp7c0P2j9bmAwkehTT8ZGpKzofYqxGPmWUXXT+Y22N/tmSi+b2ph48VnSe1kkqRE9LDNQxoaC5BKt8sFrCnCy5rKLVcffXkGxTpewmL7C2bgtlD1yk4iC/9xkihMime7auXuAL3jsSR5FnFsrTq6biZQqbZeUELV15kAOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brhnO1tbDTL0TKBNilKhkbxPI9QKKJKsEH9K79R84ow=;
 b=DjGR9iG91RHHCFaZWsDY6+7SRQ9XRo217FodDTsJHu1AT0VCf8ed1OAWESiBP72NPcUZ26D2yZHfVK2D5eITRkl2RFHrQB8g4TyID1m+x9BnDSFgoXEWpYbPe5WpZoCCj3ZhbC0c+4DB+SI4dYiTnzIRy/U+9UGWHVS1SsLk+HIvqtBu9V9TP9Xe2hqbP52WSGQx8H5Qk8YeZiRD0TC3FXwDPKCQ17JrABSyOC2ueVNwWd/LXQFvTeDBUOZmjf1jzcf3+6myLwQXjFbJilCImo1Kp/MURG7FAgTu8Dt8SW/ecaDduYl1SZ1pe8PMybrYZlrixNjL0quCJ0IkuurUWg==
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::15)
 by SY7P300MB0557.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 07:37:15 +0000
Received: from ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3]) by ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fee9:23d3:17b0:d2d3%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 07:37:15 +0000
Message-ID:
 <ME0P300MB05534EDF5293054B53061567A61C2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Date: Fri, 10 Jan 2025 15:37:09 +0800
User-Agent: Mozilla Thunderbird
From: Junzhong Pan <panjunzhong@outlook.com>
Subject: Re: [PATCH v3] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: quic_kriskura@quicinc.com
Cc: gregkh@linuxfoundation.org, hgajjar@de.adit-jv.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, maze@google.com,
 quic_jackp@quicinc.com, quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
 stable@vger.kernel.org
References: <20240205074650.200304-1-quic_kriskura@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240205074650.200304-1-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::15)
X-Microsoft-Original-Message-ID:
 <304df3ed-f79b-4022-a5ae-fb4993d4f577@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0553:EE_|SY7P300MB0557:EE_
X-MS-Office365-Filtering-Correlation-Id: a34ba257-fbdd-4fa4-6880-08dd31499a95
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwU46ctkesNAQSdI89rGQphJowvwERObqZZmM1+MdNabY8JDtiIaw3jhOWuzfFw8h06HynBLv9JsGs7vYiQ9jLrS5XUqzNUsH+17DwRfZe62sqqOjlVopJptYZBwn/+EIW8lNjIJRkLZVAgoLbWUXp0xwxNpzYGDKcTiDEz6DfixpG3l2F/2yAUceQuabSjbVRo/syvqWdeWL9qSvp0CiTaJKWamOhk/ssTlVossvKNsxlmBQBz8LfueFNbtC0KHiaoIxKTKAOqJapoPJm0ojzJh2lM++ZGsyE46iAzI1TYficyO4iNf9GPTGjrbGu3lPpxcGiyRfGmSH73sezwelFXzMkxZ1OzY3wSKHN0dJmEnpr25OhJjR8DsjjSJfoE/LPQsWTzXT+MASHcRSNxAWRxhED21MkojyvKw5ZKonlMZFWnM1wSYA8zkY001m3ebiHsGM9+Zz5yedSjXMVkTNMGazxYTHgtFxMENtjfNNQj16KDekDU5i/d/SMMGEw6mbVJbYGtYrFKumVYDl59y+00AgtJeMfhQWNSix5pzpI7ZSlL8skv6S439NQKTBn2nxIhYxNjoX8sq0hScZirgYUmf9U7axZLZZSJABZpU9IryvnkUqcLM5baYD7NtO6J/CKRD1vsJmGfmvSxPMgDUBozWQEsLzcKTZ3IsWiSCGA3Dciip0/uLZsnoO5Ohft3bejL170QtfrBHRyOqQXinnuAJlBJkxeH9l36jGwjz3YK0eATI1thHckbyt9pwQXSItAo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799006|7092599003|5072599009|19110799003|15080799006|461199028|3412199025|440099028|56899033;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U05EWlp5c3NFOWVQdGRuWmlzSzM4bVhWc0FnekQzOHQvZzR3WFFweHd4QkQv?=
 =?utf-8?B?c1NpY0d3SExkSFZtSm5RNXI2ZmdqTEdMOWhIWkhKRmNrc01DY0UyWUhnNkNQ?=
 =?utf-8?B?YzYrTit5OSt6TTJEUjNGOXczN2g4NThzd25Rc2FqY3FLY0RqRzlYK0VGTHBx?=
 =?utf-8?B?OTBhKzYvSS83QWFPQit2VUU2aG5zNTdHc2I5VmxTUXhnMENUMnQwSytBdVZj?=
 =?utf-8?B?bVhwdU1VWms3dForQkZJSXFKVjBMQlo0Y3NEWVFSNE9JcE4zMTBtcUVka0hq?=
 =?utf-8?B?MWoyMHhxbldrQWZrQVJGUHI1Ynk5ODlJcDJEa3RoTlA3WitFQXEyVDhKRkxv?=
 =?utf-8?B?SGlFNDBsNVc0bmIzUE5ycit1eDE2aU9kZzVZNVQ0S0c2ZVQxMWdRQkRYYzc1?=
 =?utf-8?B?ZGxrVjBJdWhzd0tlMk9aSGw4Vk1hMGdLR3ZiS2FOZzhGeWZVVDBzTEJ1YVZL?=
 =?utf-8?B?Mjh4cWR0UFc3YUlxRmxVZ0xLNWZNTzJIYVd4OUZhcjFMc2dFeEVsNS90ZjJx?=
 =?utf-8?B?ZHpESVNNRG03R28vcW5CR3ZEMHB5Q0pXVExZd2dVTHJKSGwvMHhIUGFUT0JL?=
 =?utf-8?B?UFlsQTBFYklLako0ZEdZNzQ3YUo4dVdJblBJVEdLcW4zUytEMW9idENwWHdT?=
 =?utf-8?B?V1Z6TkswVDBVV0E2ZE9IQ0NPbVpHdGFRTm1WQ1pNNENpYS83Wkl3aUZqWml1?=
 =?utf-8?B?akNHcEZxQmZKS1Zyb253NHEyYTFtckdJTWdtQnRWUkZzbm85MFFLRHJGUU00?=
 =?utf-8?B?UnFuVkpBS2ZmMjNqTjhtUis1N3NwbnAzL1FGMW84RGQrT0JhL0E5TW0xRUpw?=
 =?utf-8?B?T096MFhwQ2I2NlM4MnFKRlZWZmVyay8zMlhtTG5aL1dEQjk0Q2l1OWI3bFBO?=
 =?utf-8?B?MWQzSSs2RlllMXJwTzZjd0gxQkRTMzQ3MEpSTy83MmpyM3NNajNqMlByTzQ0?=
 =?utf-8?B?Wk1kTnZ1VnNudVdUanM4V080eEEzOUI2RFNub1duUHZHa2FKZDVwSi9kYmh5?=
 =?utf-8?B?cVdDQ2h5eVdJeCtCYmM0cmMxUVg4UTdNQ2FuZnNuMG1pYlJwa2dKV3ZsdWYz?=
 =?utf-8?B?SzJ4UHU1RkY3blQ4bTdIVlB4VmlNVnI5dFM4Tm5IcXAzSS9PL2RxS0toQU05?=
 =?utf-8?B?ZHhkRjYrVEQ2SVYwUzd1ZGRhZU9YVHNKNFFKSi9BZDFONkFBbG1BWGszdmhy?=
 =?utf-8?B?cHFoZTBNTnlkdWFFOFUyVmZ6ZkNjWFlmQldOdlFydlZKK0dvMWdpM0FvUlVj?=
 =?utf-8?B?T0xqR3JCZzduZWp1WitacUFTOE0xOEJsYzNhMmlGVkllUXdrN1JwNzhxVTZF?=
 =?utf-8?B?NzdIM3ROZGp0dDRsYzJsdjRybjREVlJXMFhXUmcyUnA4NlNuVk1DMnNIaUhJ?=
 =?utf-8?B?WGhyVGlEMzNNNUFtMGgxbi9EanRQM0pDVUVPaUlZcThsZGQ0c0w2cktZc3pV?=
 =?utf-8?B?Z3pRR2lXdjd3cDVtZEppZWVHUzRIQmlrTnZOdUQ5Q242QTFMREJQWm9mK3NS?=
 =?utf-8?Q?YBGpLQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkttVW42ZS9JdmZubWpCRUJsVWkzL25EWDVRTkQ4NTYxTlphZkIxMnowREhM?=
 =?utf-8?B?eUZMb0RUOGZIV1J6YVBSeWRjejdtSGFDT3hmazBOR1FmVy9kY2hlTXZXSTBq?=
 =?utf-8?B?bXUySUcyN044dGNOYjIxVFZEWlNQZ2NIUkRGSWJjTk5yUWxEWkRDVnNPQjdX?=
 =?utf-8?B?alMxUzRMNUhwV2R0OGJMSlk4WnJydHlvS09LeEMwdVR4bFJrbzBPZUxhWmRN?=
 =?utf-8?B?aVc5ZzZnUUZnR1BaSTZ4THlUNmVvRS9UemZqclJtVjQ4Wk9SY200bUhwNllV?=
 =?utf-8?B?WFIyY05yRDV0OUc0OU84VGozS09DWnNkWjNWZmdUdGxOUGZWYXNDc2pFRktN?=
 =?utf-8?B?WDhPcHNYNmhtMG5yaUw2TXFoaE1vR2xqNVdtcVp3c2VCbjRzbllaN1lWa3Fv?=
 =?utf-8?B?dGJnUWpCeXF0SXRHRWtPYWdQY21EKzQrOEhwWDltM3hzU0tUVHR5T1JTSE5C?=
 =?utf-8?B?ZUd2UFVoYkcxSExpUVJWdFRyZlVNUGxYdW11UHBjOVVBS21aOVI5aU9TQUFs?=
 =?utf-8?B?cHNldVZxS08zYXN6akozNTV1dVNqQUwwazJoTDlXOUJqcWtyYlVZNXdoZHJt?=
 =?utf-8?B?c0ZleVRvUEl5VGZKcEU2Y0tXUHNTN0toczhLZ3plLzRYVlE0c2xBTkFBcFZ3?=
 =?utf-8?B?NUx5cWZXR0Zkc3duNVg3QU1wZkI4VWYxclNaKzNlQ21laHBFNGtnQlJ0ZVZw?=
 =?utf-8?B?UndrS0VBa3JNdUZiYzV1VlVVWVpPZFRvamhWRGltSFBkV0p6ZFArRmhYZHBE?=
 =?utf-8?B?RTZRemZZM3FhNFA1aGhqTU0vSVdmcTR1WmJ6SDIycjk3NTZXZlNjVTlBNy9T?=
 =?utf-8?B?NHNlc21ZOXFhM3FTTmsvRFA2b2tJODE3MndXY1U1QnJLRzhYSmRrQ2c1VjBJ?=
 =?utf-8?B?aDBqTjZSN1JQNHVXWGlobU5iWno5cHh2VWxCMXlLVlBZVm5hSzFzOUhrVm1E?=
 =?utf-8?B?WTBSeXBNMmxJZkEyeUlJaWNOaHR4bVFJREc1T1lrM1ExSzBEUldOeC9pdzN3?=
 =?utf-8?B?OHFRd0VnYVZxV2QrbEpSb0NWSGVQQnJ2TlYxaFFBcWVqZkJEMUlvU3JZOEph?=
 =?utf-8?B?WXFKWTNFSFZRQ2I4ekJuUFB0M2FjM1l6S09DaEd3WFRWMlB1OHJuYS9MSCti?=
 =?utf-8?B?TFFCVzRqek5uWnVWdVZjajUyZnNaZVZoNDA1K0k3SVBUMkNEaUNDZkorUzZE?=
 =?utf-8?B?b0twREZVSC8vU2FpRlJ0UnRkNTBybzR3WWhGNlBUemlnNDgzQm9XWG4wUzdw?=
 =?utf-8?B?ejJaeG1qWE1oMkU2MmlGbGM3TFNFWHNXcXc2VlpjKzU3RVR6SE5PZU5oNjNT?=
 =?utf-8?B?RnZ4VnE3clZ2SHNsOUtSeC94VHpPRFB2THhHbms1VCt1RGMxRTdxS2EzU3Ra?=
 =?utf-8?B?YVR5d0VVMlpKa2N5TmREeEpwREdDdHh4bFZuKy9EVXpaWHQ4S3VMUGZlbTZw?=
 =?utf-8?B?L2dEcEVGb1orYTJyN0FGTTh2YkYzMzRPays1SUQ5MUxNNEJBUDFzbXVZN2E2?=
 =?utf-8?B?Qk9YRXRQMUR6UkF6RFA5clovSkNRL2Z0QTZ6OU1xYlhkLzl2RS9EeXU3ajVD?=
 =?utf-8?B?TGVCbXBWZ1hydEtkcWRRdFJqVWozZ1BHcW1pK2hPMTZEVnpCaUlDczd2aFhv?=
 =?utf-8?B?aFBBTTZvdXBrRzVLeTJpMVI3dGdUZEhhcnNSazlONG9PRlV1QXB2MTNMakdv?=
 =?utf-8?B?U0k0OUNuR1RpZ2xFY0NzTVFvRk5pSm9Pd3g4TWZsREkxeFFtN2NTa3BLTVJJ?=
 =?utf-8?Q?DxIfVj1F4aThJvMvVlm1iSQEXCCnfeGaVDoPO5A?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34ba257-fbdd-4fa4-6880-08dd31499a95
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 07:37:15.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0557

Hi everyone,

I recently switch to f_ncm with Windows 10 since rndis 's safety issue.
(the Windows 10 driver version is 10.0.19041.1 2009/4/21)

It seems Windows 10 ncm driver won't send ZLP to let udc properly
separate the skbs.

On Mon, 5 Feb 2024 13:16:50 +0530 Krishna Kurapati wrote:
> According to Windows driver, no ZLP is needed if wBlockLength is 
non-zero,
> because the non-zero wBlockLength has already told the function side the
> size of transfer to be expected. However, there are in-market NCM devices
> that rely on ZLP as long as the wBlockLength is multiple of 
wMaxPacketSize.
> To deal with such devices, it pads an extra 0 at end so the transfer 
is no
> longer multiple of wMaxPacketSize.

I do the iperf3 testing cause gadget constantly report similar error after
a litle modification to get more concrete info:

[  174] configfs-gadget.0: to process=512, so go to find second NTH 
from: 15872
[  174] FIND NEXT NTH HEAD:000000006c26a12c: 6e 63 6d 68 10 00 86 16 b0 
3b 00 00 48 3b 00 00 00 00 52 34 fc 5f 90 fd ca 40 c1 f4 f4 6e 08 00
[  174] configfs-gadget.0: Wrong NDP SIGN of this ndp index: 15176, skb 
len: 16384, ureq_len: 16384, this wSeq: 5766
[  174] NDP HEAD:00000000298f3cab: 2b 12 48 8f 12 ce 3c c8 d7 39 c0 0d 
15 cf 86 14 17 4a 91 85 db df ad 87 f0 35 0d 76 ad 4d 4d 74
[  174] NTH of this NDP HEAD:00000000af9fbfc9: 6e 63 6d 68 10 00 85 16 
00 3e 00 00 90 3d 00 00 00 00 52 34 fc 5f 90 fd ca 40 c1 f4 f4 6e 08 00
[  174] configfs-gadget.0: Wrong NTH SIGN, skblen 14768, last wSequence: 
5766, last dgram_num: 11, ureqlen: 16384
[  174] HEAD:00000000b1a72bfc: 3f 98 a6 8e 17 f8 bb 29 07 b8 da 13 7f 20 
80 8e 77 ca 32 07 ac 71 b8 8d 84 03 d7 1b 96 9b c4 fa


Lecroy shows the wSequence=5765 have 10 Datagram consisting a 31*512
bytes=15872 bytes OUT Transfer but have no ZLP:

OUT Transfer wSequence=5765
	NTH32 Datagrams: 1514B * 8 + 580B NDP32
	Transfer length: 512B * 31
	NO ZLP
OUT Transfer wSequence=5766
	NTH32 Datagrams: 1514B * 8 NDP32
	Transfer length: 512B * 29  + 432

This lead to a result that the first givebacked 16K skb correponding to
a usb_request contains two NTH but not complete:

USB Request 1 SKB 16384B
	(NTH32) (Datagrams) (NDP32) | (NTH32) (Datagrams piece of wSequence=5766)
USB Request 2 SKB 14768B
	(Datagrams piece of wSequence=5766) (NDP32)

 From the context, it seems the first report of Wrong NDP SIGN is caused
by out-of-bound accessing, the second report of Wrong NTH SIGN is caused
by a wrong beginning of NTB parsing.

Do you have any idea how can this be fixed so that the ncm compatibility
is better for windows users.

Best Regards,
Pan

