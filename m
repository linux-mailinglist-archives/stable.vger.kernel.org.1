Return-Path: <stable+bounces-103967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B312B9F04FC
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 07:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27CD188384B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 06:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C19B18CC1D;
	Fri, 13 Dec 2024 06:43:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7318CC1C
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072209; cv=fail; b=kVeNfrOauNQyEp9WzHi9C9kEABuVLEZ4mDxnaeL3t3Gn2x0C3rH9gc1mWwdo16N+D3ft2CpfimUgK/UFHnmcOqfZe2ul5PewCPzRbKr16g6qRdvkPAQBIQzMi3FNSFOeWgdwjyRmschdp8GD7ulOqNraQiimB/y0is3vo/b7Yvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072209; c=relaxed/simple;
	bh=k2xOcRz6oLiDodiricRvUo1vHXjloTYsc0CzSPyqzgU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J6n+sHUFYzXZaMlKBTX6fsebH/iZAaAw9SRS0zm+14AdCNfDg/HYv1zY5+vivyyk8tjiJVCAgt2EevmS1OZWx7y0l7Cn9KU33INNFmtJQ0QUSzA1Ftb808fG1EZxsaNW28R1dxZA0uOjVzkyZLlJP0dcYSzIHKUP0MCBOqyYryQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD6U2Xw000965;
	Thu, 12 Dec 2024 22:43:12 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u6sng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 22:43:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvlrIIKC1ULuqbJpMEdespg05yXzGvShZF0PpBnnGF3PWzKtPb1Uj6LePPN3aGB0EoLM1sx1hv6HmqrEATEuB8vhQ+/u6HnAFUvol+hGysO5D1E2XUykNLp+LCboYbAiqdGJQlCN46c0ZI9Ai+X7a8et6/mrynYUz7zQ1w6yRH6hriv3fcvRUgwjPf8OdvMtwnqXXxKyOMxMp4fJZFw87thuAyihC1bmbe8j5EqEjw6Y5TKU35xl/env1fytHzKIGH+xkzV9HP5GOLqM36WgVGUkj26D8kLHFHUWWJj8hgDCokXGdu/KIprSut9yRWlDt1S74uIW5lHc0eZCxmoxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Uq5AD012n6LogqYp+1gpMxZBJmrBkjNoHEfoPblBuw=;
 b=kvwiZ9+ywb+QTJkRWsaNJ/LxUJrdzDmGxGxCOcSpxejHzeg6KCLlW8znUMhcPfYDCCT3gFVyD7kjzb4QTdi958GdhcpIJTkyLaeLRdL3HP9cL7DkrDajPnXwpGsX7X3/vEa5HWYPGihMne6rhy7dRZTAJYcJVqT0PHwmIgI423bDR3wj6XPaKDzShOdwJnvj9acuLdBmnG+1BRrPpue/WboOQYs3qEZPJAzLyEenXpjcDR5DomoUkgvSc5CCt2JfDsIlKnmM1GTM7Ua1KjCuu3LxK72MvpiVabq3xRHCT5uZucZO+iQeEtmlIkjAOsMewwIJcvrtc4T4IdJ4WRducA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 06:43:08 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 06:43:08 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, alexander.stein@ew.tq-group.com
Cc: u.kleine-koenig@pengutronix.de, andi.shyti@kernel.org
Subject: [PATCH 6.1] i2c: lpi2c: Avoid calling clk_get_rate during transfer
Date: Fri, 13 Dec 2024 14:43:14 +0800
Message-ID: <20241213064314.3560854-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1a74d6-4cfd-4c0e-a549-08dd1b41676d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVhCOFV3eTNBUU9xMVNwWEhHQnN2MGNoWjRMN3VBT1ZLRjZXbk94Vk9FMTlP?=
 =?utf-8?B?MzZybTNRRnVYUjBPWFp2SmpnTkk3Q0tOUU1RVWFaRHY4UVdDbHp6S01JVXl1?=
 =?utf-8?B?YkxJQ2RUSy82bWsvR3hOMWNLWXFiZ0NHaVpVYjcyMGxLT2UrWC9XR0c5QVpi?=
 =?utf-8?B?YUY1U2Vmd1Q0bThzOGJpWUo5Uk9nS2RZalp0UU1MKzlGTm9pT3BlMUVmRXRT?=
 =?utf-8?B?R0ltNEszYjRVV003V3BnVzJEQk9ZeVZRK2VaRi9wbVhBRCtwMjlvc0NKZk1k?=
 =?utf-8?B?YmJ5cEVyZjFseUwrRXM3OXpjcVNiVmFtYkM1djNnRVJjL2VrS3FDakFQVTNR?=
 =?utf-8?B?Q1VjcUFMV3dacmlFTzNmTnJIc0NyS2puRVhCbkZoMGNvK1ZSV1VIcFJQM1A1?=
 =?utf-8?B?Q3BZUXNmQ3J0OFhGSHJVQ0h1SC9zTmJiQjdjRlc2QlBpQlZsUkZQUjJvS0t0?=
 =?utf-8?B?Rk5rSTVzZFNobWt6eFk2aUZ0K3pIeGlFcmdiZVlobGxQUUlWTDEvRUc5VXhB?=
 =?utf-8?B?S3dBVUhqcFQrVmJ0T3FtRHM3dzV6Y0w0Q0N4aWdGYTFkUzFDK25LaWcxVkg2?=
 =?utf-8?B?YjJPYlFCcDN6ZjN4Q3pxWDNEcS9LSWo4WG9qN0hSNmh1TVFwT0g4aWo0NUp5?=
 =?utf-8?B?WFdCSFl6aWxnKzk4OEhkbkprWDlGOTRzakFBdXJIOWFSYTByUGg0WFhYaGgz?=
 =?utf-8?B?cy92dksrYURhRktiR3A1NmJiYzREblEzNWx1YnBNNnlRaGlDMk5uTGxPM2Ja?=
 =?utf-8?B?d2NucE1mWFV6b2JxaTcvazRQc0tsOHlYRW93bVpuYUhDTzRPTE05NVFvOUdh?=
 =?utf-8?B?QmJqMlVLS3hmRFRsQllaTmZVYjlCYnlhczMrZjdmeU8zcSt1WWhzckF4RTVu?=
 =?utf-8?B?T25mRVlyakVCOCsrMGJXaTBrWkR0UXFiV0IxaDJYdGpLZmMyejZPOVd5VlZI?=
 =?utf-8?B?bEFFSkNDblo2NnEydUV4RGQvZ3pDeDdWN0JxUFFTeUpsL0RKN1hqaXR0RU8w?=
 =?utf-8?B?cmFnQkdicmpwZHRna1p3Uko5SjZkb3lkekRiMnV1YlFjQUYyekV0U2h1TE81?=
 =?utf-8?B?TGwvazVRTU9KNU02K1dQVVdYZm5rK2pENG5leHRPRXlwOG9NTWIrUE40Zisz?=
 =?utf-8?B?YytWdjF5c3JkcXBNTUVaQVE2SXZXZjZxaitsQ3E2TlVIRklvaFV0VWhCanJS?=
 =?utf-8?B?dEFwUmw2ZUs0Y0o5Sm1NMHNsK1Yvdk5ka1d1RmwzMWhTeFpzK2hGTEhIaGR5?=
 =?utf-8?B?b2pSZktpbXo1K0xoLzhXWEc1NUJ1cWpmYTl4UEU1MWNXa01DcVZXQjhEOVoz?=
 =?utf-8?B?bmVWaDd6aWlSTnM0Si9IVmVtT2lUb2tTSkZQSzRaMGRlV25UVGhnUGd3ZCtW?=
 =?utf-8?B?YytxVURMbGg3V1hqd0x5Tyszd0pVMnN4ZWlPckVjaFptTFZuL0dSazdCMXA4?=
 =?utf-8?B?YjIxYlpqSW5DTFJjVmpWNkFlQW0wUDFwcU5CbjA4ZExkNFdNMEswTlpDajRm?=
 =?utf-8?B?cUF6aXhTYzk0S0M1OEE2dDVjUm4zQjZtZWlIcmNsbFRwK0I0aW9nTDNuMmph?=
 =?utf-8?B?ajBOTktFaldRa3RDMkRxdjIvS0h5TCtWVnc0UzhUYjN5ZHVzYnA2cElNTXFZ?=
 =?utf-8?B?OUNPSVJhTEEzdkE5NTJ0dHpoT2NVbkZGYzh3RFNEZU11M0QvcnlwRWdqOEV1?=
 =?utf-8?B?cVk1VStjdkpJb01YRy84aWVuZVFZZWNkUTdLVzVIenZXSEFHS0NRQ1llOXZI?=
 =?utf-8?B?anR4YWRTdnVaQ1Q2RVVPNUowS2krelh2WjQ3OGVzR2RXUi8xYXZKTzVNTXU4?=
 =?utf-8?B?dDI2SWZlVFlnYTcyL1ZWMXNRRjZ3QzZkYTFmS1c1STZ0TUxyQnJFUFNENk1p?=
 =?utf-8?B?SUNBdURvRW1PVzNIaXdDOG0xVzRyb1RkM2RLck9OaUlMTlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXZWMlFaQW8ySVhSSlBONWFJQ1Qxb3RYNWNLYkxMbDFVTktNeERNNjlxL0h3?=
 =?utf-8?B?UXFIemlGTkJ5Wk1wR05CRUE5SkROOWhBWWpMYjRCMS96a0duU3o0VUxlYWl0?=
 =?utf-8?B?cmJnbXF0NVR0KytYT2FWdHl3MGRKU1JzWnhyOVpKS0ZwWXV4V3g0Q2NwNWNl?=
 =?utf-8?B?dVQyWVhZNVNUTlF1WUVLRERVSUdWUzNYRzg2L2Q0NzJGellXTHhxSkFqRitp?=
 =?utf-8?B?RkpmdW13RWxYa3Z3NFdtNnhPeVU0cEh1TWNxdUVuYS9memNwQmorR2hQdkRy?=
 =?utf-8?B?UVlkUk5IVnB5UTNBNHltQTM1K1oyaWpza1Rjb2tSeFFKL2ZheGJ2TG5hbFFp?=
 =?utf-8?B?b2hSbG1kbWxOcFc5OVhKQ3o1eXRuTDNmcFA2K3FJTDVZeFZMeEpPbFhtZ01u?=
 =?utf-8?B?TThOanNaNEJCOVQvZVFxNGxlSHFLaXc2T2ptR0FYZFBWQ1BSampHcndqRmla?=
 =?utf-8?B?cmdHQXp2Vnh3RkgvbXBlZWZ6TTNJWU9XczdsNlk2WFFmOTB2QW1VeldYSS8v?=
 =?utf-8?B?TnNjakJRRnVQQjZmVUR0TC93dzRZOTAvd2Rpb01LWWp6cVg0TmhaVC9DWjR1?=
 =?utf-8?B?WmVOUkdvMC9kRCs3TlFFbmdZV2NrODFyNGhxQlV2aFNXVXBKaG9BWDBTL2Jw?=
 =?utf-8?B?TGdkU0tYWnlMbGpRZ2pyc29WUnJhK2JkQktSMjJqdW50ZCs4Q0h0TXQ3WFUv?=
 =?utf-8?B?WGxtUS8rOFFSY0gyaWIvU0lmM05IajdhcmhqVWVEczlWRVgvVVVUTzFhekdX?=
 =?utf-8?B?RGZteERZM1psZk95eVVJMWNqQnlqYWVmOXpzd2VxNlh6dkxVOW9PVW1DSVhU?=
 =?utf-8?B?UldSSW5DbTJaRWFXei9nYUh3YUJVbk5KRTBnbU5DYjFHc3gxOXdQOWtyQ244?=
 =?utf-8?B?bW9Va3pHdWhzMWlVQWtUUnB1N3kyanBXd1JDTVc5MTRJR0M3ZUlGL2VHQk40?=
 =?utf-8?B?WnQweEd4R1NVVmYzcThiNW02T2NjTFlmMkxpYnk2N1Exa3dBYVFzZ3dURFgv?=
 =?utf-8?B?Y3piamdRTjR4aFdDS0ZyTEFjek1pcElic3VnWTN2QzdkZkZwZXBBUkJwRUZJ?=
 =?utf-8?B?Z1BHbUl0MjNXcm4vZU1jUUhCcDRGMUdDdDAxOFRhcGVrN29CSHBOUXhONGhR?=
 =?utf-8?B?RnU0c2pwSFc0ZTQ3Z3FQRXNZd2VhWnhzRi91dWRnNWNpRE5GNmcwSUVSODBk?=
 =?utf-8?B?Qm82NUY1QlVWbnlHaFpWU3NkZllWdVlXOUVra2N4TWM1eDN5a1pxZDNCSmo2?=
 =?utf-8?B?em1uOTFrcXpXU0dVaDNRbzMxVmR1RHZNcXJZMVpRY2ZreTZlblArZG9DeHpI?=
 =?utf-8?B?bEZLdlh0Y1k1bVNZUmo1dUlTS0I4SWRJZyttVWJnNzNwSThNRjRZOFFBNGxJ?=
 =?utf-8?B?VG1WNFdZb1AybE9LNlZOOGo1ZTFobWF1Y2hiUEJDZTJUczRRYllUelBlcmth?=
 =?utf-8?B?YmRKZXFIeTRoZU82SG5xNjZDNHFpcklXME5QUFZIR0ZROExqR1lBOVlIZXls?=
 =?utf-8?B?NXZBTC8zR1V3WDNReXhzZFl4cmdSeHhIVG5ROFNVZnRIL1FQKy9TaHBGSCtQ?=
 =?utf-8?B?ajkvTjVwMzZpTTdrc21lcGJKMnVwYXRraGJCc1FHbW1QRDl1RGNQbFFNK0tW?=
 =?utf-8?B?WFVYWk4xOWJPN2VqOGlKN0taVlp0bG91MERReDloTkdlY1NMS3ZhVmdDSmlO?=
 =?utf-8?B?M0dISTd1d1lOeFZrZFRnRHdTMWZEeXlRdTVwMm1pZjN2YnZOdVlrc0dTd1ov?=
 =?utf-8?B?dlRtZnJzUE8vSUJ2RTJFRXp0ZDB5VHBpUEZmNzBFT0UyUGE3dzJ1dlM0NjIx?=
 =?utf-8?B?WHpWbVR1MzBWeG5jaG55d1BUUDVFMythdUcwUHhrTktWNFJGVUVuL0I0M0hB?=
 =?utf-8?B?N0xCREJsZy9NNlFpcVRMY1haK2s2OXlQTEhHMjVsZWFVUFFMWnRTZDRMNHlP?=
 =?utf-8?B?YUhGSDY5R0k3QVBYT3A3ZXhKQk9RMG4vZ3YvV0ZiOUt6UDBYQzdzc1NXbDNp?=
 =?utf-8?B?cXlWOE0zQkFZekVqQkpPSHdFYnVBKytKWHU0Z1BhemF4dFIycyt2U29URWFN?=
 =?utf-8?B?TFpGdjBBdlRuV042Q3QvWUZ3VkE5ckthMEJ6NzJzVC9jZm9OaEcrYTBhZXBF?=
 =?utf-8?B?ODBYKzNHYVZKN1pGcE9yYkZjekErdXpBb3RYSFQ4ejJPc2FScXlmQkQvSS8v?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1a74d6-4cfd-4c0e-a549-08dd1b41676d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:43:08.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNwzUQz5jkO8CrEFWWANfKqyVFmYE+3os1z3DdU0cSzIO/qIwaE6WzLrvFUdC5uyI2CoSQx3Q/hr6VxR1GIA7DjafAtTcLBeJJLWlI7dGZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=675bd780 cx=c_pps a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10
 a=8f9FM25-AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=LlKcoB04J98ZsV19NOoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uSNRK0Bqq4PXrUp6LDpb:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: 9CmCTI3LuQkuin1PzizL4wgHkBM6XCBS
X-Proofpoint-GUID: 9CmCTI3LuQkuin1PzizL4wgHkBM6XCBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_02,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412130047

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 4268254a39484fc11ba991ae148bacbe75d9cc0a ]

Instead of repeatedly calling clk_get_rate for each transfer, lock
the clock rate and cache the value.
A deadlock has been observed while adding tlv320aic32x4 audio codec to
the system. When this clock provider adds its clock, the clk mutex is
locked already, it needs to access i2c, which in return needs the mutex
for clk_get_rate as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
[ Don't call devm_clk_rate_exclusive_get() for devm_clk_rate_exclusive_get()
  does not exist in v6.1. ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index ff12018bc206..270197ac995a 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -100,6 +100,7 @@ struct lpi2c_imx_struct {
 	__u8			*rx_buf;
 	__u8			*tx_buf;
 	struct completion	complete;
+	unsigned long		rate_per;
 	unsigned int		msglen;
 	unsigned int		delivered;
 	unsigned int		block_data;
@@ -208,7 +209,8 @@ static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
 
 	lpi2c_imx_set_mode(lpi2c_imx);
 
-	clk_rate = clk_get_rate(lpi2c_imx->clks[0].clk);
+	clk_rate = lpi2c_imx->rate_per;
+
 	if (lpi2c_imx->mode == HS || lpi2c_imx->mode == ULTRA_FAST)
 		filt = 0;
 	else
@@ -594,6 +596,11 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
+	if (!lpi2c_imx->rate_per)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "can't get I2C peripheral clock rate\n");
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
-- 
2.43.0


