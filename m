Return-Path: <stable+bounces-206114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB087CFD225
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 11:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E826E3019BBC
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D3C2FB0B3;
	Wed,  7 Jan 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Bcl89HlE"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CB2F6925
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780954; cv=fail; b=nFZENjOuuQGwDO0/vF1EITjBCMoo/FnVbJtclBwpKNkquhUyjWbDcNtxZOgd6/1cREm/EvHnpk5WSIZk/lu5wRouq5Cz7usVFFvCvVfvD2gC7DRzWnbSrQt4fW2CpqhnpMfgo6yoqwsvTociEREZHn2O8e7Z1ga6ZvljcGQD4G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780954; c=relaxed/simple;
	bh=dkHhX9+C36/VxZK/9OJSfwemg/2A9zpMHCj2e8xGJ0s=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Qsl8ls+hytOevwvG9fsRrEKa3yt8q5hxVJOfHQsP5Nweh/j9NtqKeBBqGXgw4PZJNkzjAm3+kpK/2ht0sLfXV/QMEtpGfss7tIWtaRWqc0GUcnAncQMgOnhRDfurqUqyEoAFuuiy99uhSJZE6rlhWPBFlmhYcB5njxy6KoDZykw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Bcl89HlE; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk/ylDc76VZ6YOG21rHsyMm2GM96nqnnKSkX+BVNd5ZJXKDuGsqQ8EeOTAQnNXHVR87mzPp3A6zFwxefPhLH3qkM4hFgnKzv29Az6SyupCHcA/F6qssUTWF2aSbPR9hMyZkcyVho1jAoLdrKdlzzl3dta8M7lhohE3Pw9ugBq6ZfXYhpP7fPPDnQ279KuJg3zY4a/8i9rhgMr9Yqz4BxJGMfrGECDNKrV+bQTV+pz/RCgb1vfketojdwB/LjZ1Usi0lAAgZudR6B8nMVOMgMf63CLp6E0RFyYfwmcZ2yFEdsdBB62cXgwq2hBOBNVTUSriqnODwlXEY/yi0MkRPr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhrVIawV4Ep64SZn0TULq5n0alHsSQo+1t+Z5/P8zKQ=;
 b=PRwgv0+ngUJvo5gj8JHyCM71WpPQ4PCFJI2nplD2tdJpJtRxxLbo8gHA4Pq/P10maMa0FbImZ2nf5c3W6PDuZtOo2OTfegx+D+iONJqPVP7ZJ16kRnrSBKyw4YewSIPmL7K0uZ/uSQRZDGPzNkGoSm9xD1UMouYlkWxC7aWsw/0yFnroq6lS/iiUgQvz2BU6nQhmH1HgQOEfVkLFMDD2xrv2tH6vwDs+zHQV5ngYNOkYN6EfM4vqHhwmPyxCyAk6/+F3YovCN7wYWVtxxyekwjGKf3YAzXeW1TkJcR3W2SqePngnTlTl7ZOLKKJw4Fw3B8dyYAzhK95/4Zkzy5qckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhrVIawV4Ep64SZn0TULq5n0alHsSQo+1t+Z5/P8zKQ=;
 b=Bcl89HlEuOwBunS7bz8BliiktmJ+EySXYaoTXFW2d7a76xk4TRHtoI5HNel2cSugmDOmmTfhVAhBhh+vHrsivCajTGlsTuum24JMMFPFwaN418JKG/GetLO5ZRg1dxJT+uKbFDfVmk12B8h4nONxPE5mgU7ck5zfezNx9abkgvnmq754Ett+zCU18Cxax+/DgoV5e7UlmWQfP4+J10NRejmRfandjMqYpxDGMBj4uBsK029mfssL5yKMKqIXFfumbQ876JXMmVLIurjbef4rK2B9tRnxn232bawx15lyN9i4IJUqmVmEurt8lqL6pSFHd0tfTlQHTAhbRiv99zO1Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by DB9P189MB2051.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 10:15:49 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 10:15:48 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Wed, 07 Jan 2026 11:15:26 +0100
Subject: [PATCH 6.6.y] drm/amd/display: Fix null pointer deref in
 dcn20_resource.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260107-null_pointer-v1-1-7443ed011f10@est.tech>
X-B4-Tracking: v=1; b=H4sIAD0yXmkC/x3M0QpAMBSA4VfRuba1jSZeRdLGwSmNNkTLu1suv
 4v/jxDQEwZosggeLwq0uQSZZzAsxs3IaEwGJZQWUlTMneva7xu5Az0TdhwsFqWWpoaU7B4nuv9
 dC5pr/kD3vh/VcXeZZQAAAA==
X-Change-ID: 20260107-null_pointer-0bdcbe3461a9
To: stable@vger.kernel.org
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Sasha Levin <sashal@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767780944; l=3867;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=v4lbZkr+Edi5KJiUcUlR26RkYgTi472wfExh+nZpX+o=;
 b=mdSLXLhgkiANTkFffvhn8dbafGMCj1xfzOr5rIzO01hdgy4B1ZX1OjRdK+kt3Ib1h1CDLatPI
 AieK2QFf5DGCu+S0cyXy4IEDZMRAJiCVX16UspkKHSLyWDlc1jrl7Xp
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO4P123CA0201.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::8) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|DB9P189MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: de0c8307-ab2d-4f4d-52ad-08de4dd5ba85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1pLay9NdVhSZEFzMDh4QldGRW1Ya0cyUVRGcms2NWg3SElhT2Y5RGg2UEkw?=
 =?utf-8?B?U3NtU1dySWltL20rVnNVSkJXSG5SaWFqWlBnYmpYKzNESyt0Z3dodm5iaEND?=
 =?utf-8?B?M2d4S2ZGQkNxbGdJQjJWMmZxaUROR2JGWkFkc2FTSkE3VU1qTVAwKytKNDdC?=
 =?utf-8?B?ODNEUUE2dDNuVUtBNlF2bmFQaEtYRlBQa3dpeE1SUTQvTE1qRFQ2Y1J4bFlP?=
 =?utf-8?B?VWptWHBZSHdabWdCcFlQTDlUME5ZZEVzUGdydzNLYTlLTFhKajMrczlvU1Jq?=
 =?utf-8?B?MEdXQ0ZDb3RKWnFVdXYxWE1pQUJHVURkQXFyMUNTNG5IZU9hdC9vc2VaUVlW?=
 =?utf-8?B?UzNPMEtmNGNtTXVXUTRzMGJpVi90elltSmlrQlRVOHZHVnQ4YmdEclFmQW5X?=
 =?utf-8?B?a2pNUngrTTlNTzNzaXpKdXlLRTJFQUZNbXNGUWJMYUg0ZGdxc1lEejVTUnJ2?=
 =?utf-8?B?L3dwWVVsU2dTM0E0VXUzSWQ5cndBc3YwNUhYRlMzbUVpZ0xCcUVEcC9oQllv?=
 =?utf-8?B?UkIrdFVqYWM4SEE5cHJVQ0FlRlhGNEtCTk12ckk1dURyNlVES2twYTh6L1dH?=
 =?utf-8?B?TmRaR29KdkJSc2plRU5jMWJvWTFUenYzQXMvM1VzWXRQNmp0a0FlVUNabnhN?=
 =?utf-8?B?K1ZCOUxVdE5URnZsTzd0a056SlVJRWtUMGJpNXVqeGIyZC9FYjVmRkM1Wk5J?=
 =?utf-8?B?aTZ4Q2JRVzE3ZWJjRlAvU3B3d3ZWb3pObjB3eEVKQml1dW01ZHJFZjVGWDdx?=
 =?utf-8?B?bStmbDdYb2tBYUZKNDhsejhwZjQ4TWQyTmt2ck4vT1lRZWgxK2JDUXg5NDRm?=
 =?utf-8?B?bjlpcU92SGQyQUxFVXlUMzNTbFM4TFBUNWlGekZVY3ErM3JVc3RZUkdjd0NK?=
 =?utf-8?B?UEpnRWw1RzlXcWNmdGp0L1dBUzZhZDBCMXBSVExudmN6d2ErZHlsdnNnMWQz?=
 =?utf-8?B?UHU5S01jd005eGZwSkNoS1hzcHJwSHBxWTJZT1NJWTd2MTFSOUoxWmxPN2dN?=
 =?utf-8?B?Ty9rdUlwK0NKMWs1Ym1WZkVHR3BMTi9Pejg4T0Z2MEpOQWNjOStTSGtFc0k3?=
 =?utf-8?B?N0t2dXpxS29DODNwcVJreEF5Z1lmUTNDKzlPYUJxL3JMM0pXWVVYUDVxZk5F?=
 =?utf-8?B?ZXBKbmRBRW9ha1dqMHZ2aXRaWk5GVGNMTFpMelFQZzZMaFJveXVla0Zybmx3?=
 =?utf-8?B?eDQ1amlpQ1d1QVRxNERqVlgzUll4ZTFyR2QxVlp6UzFvUUtORTJZN1NaazF2?=
 =?utf-8?B?d09CbWRacWl2SnRmYk1OWTVMdWVHbWNlZFhyODN5bUhEU014NnoyZ09jVjYy?=
 =?utf-8?B?R3haM0RDSnVMZDNyZXRXSjE5WURab0w0RlAwY1kwSXdnbTBMbzdnY2VXSm0r?=
 =?utf-8?B?YXV3WU9XSHNIaW9DN0dLemFpZmo2UHNBL2NnK2xIT1UxWDI5M1hzVkdWazVJ?=
 =?utf-8?B?ZGNYM2oyT0s3RGtWcGZZTUk1ZjdwYjdiTjFWVnI0Rzg4dk82SnhKT0JXb1I4?=
 =?utf-8?B?UFA5ZTNoTEQ1VGVQL3ExdTVTemdkRGtNc0pUMUxwVVNGeit3eC9tcURtbndK?=
 =?utf-8?B?YnRQQjdIOWJqRk1VbTlBN2RHQ2tlL2dycmtKQ1RtN0lrVTZIMzZqUUtwNGx1?=
 =?utf-8?B?aWMvZ2M2azEwbS94MGxubS9rQ1UvTCtqd0JDZ2dlUjdtMWkzUHk1bWNJR2Fm?=
 =?utf-8?B?OU9ydTUrZVIzWUpJaktsZjdYc2h6dEIwN1c2Tk84SmlJeWlvOGdXSWQ2NGQw?=
 =?utf-8?B?d3ZaK3c3YXdZV0dJZ3kwYTF6SlJCSU05UHB3elM4NitpVWFwZFE5ZnFucmtm?=
 =?utf-8?B?N3J2QVRxNVBjTG9oRWhLYVBtYUZYSEx2M2tEd2ZSQ21NUDkrTXlHN0F6MEZm?=
 =?utf-8?B?THd3dHVyNHZLeFFqMC8xMkl2Y0w1YW5rYWYxcVlOMWpQdE4yK3VpN0NmTWp2?=
 =?utf-8?Q?TaIBGCuicKQhTjuosf0SMAwgWrBS/12P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFl5RUlHU2lEOUdNN09RQkVvNmlaeStFQ1pTYS9CNGdDNWliWGpTNElCbGRJ?=
 =?utf-8?B?ckF4TXhYcGdCTGFVZWdsRFQ0Z2NqMDZGQ1UyMGdNRHAvcEUvdDA3b21LNFRC?=
 =?utf-8?B?Ym9BMkJRZWVFS3Y1T1cvd3JvT1diQ3NLZ2diaDdGcTBTYmx5RkdwUmRpWTAw?=
 =?utf-8?B?SHdMY3NNSnlXYUJBVFg1Y2RIL1VGT0t6YS9WTHdvWkJyTExVeTBYU2pTS1Va?=
 =?utf-8?B?UFY5MXhjdytNTDRXLzB3b2tSV3FrQUFIM1Q4d3pVMkFnRDRuMUgyYWtXZFQ5?=
 =?utf-8?B?a0ZtVmFDeEVKRFhEQjZFR1AvOER5L2JrNXlKelVlWTYzWHZaMGxsU3dJWUtm?=
 =?utf-8?B?Tmp5a1d6Q0d1NGlxc01aSHZZUDRjTDRpb01TTWp5YnN4KzlZVjhaY09vWDJm?=
 =?utf-8?B?c1RPUDR6YWUvN3laR1FXczIxWWk3OExmY1JhT2pJVW9EWEhTWmpHck5MRk5w?=
 =?utf-8?B?Y0laRUxUSllPUC9TNDE1RzVvL2ZOOHg0SElaVFJqNFpVNEJZeVpUZHpTRTBF?=
 =?utf-8?B?eWdxOHZJaXdrZk5OUEFXaGtvckZCSUI2SkUrUWRkb1YvVDFBTDVOK3JHRmwy?=
 =?utf-8?B?bUNOTXF5bHo0aGlEUDJvMlE5VlZjclJkekZ3b2xXYzhHU08zQ0lRbWxhVWo5?=
 =?utf-8?B?WTh2RktYU2F0NC9iNHJQaU5DbWpjbUJOR2tZdnpqLzNUbTBwMk9oaCt1cGJ6?=
 =?utf-8?B?UjZEUDJVRVBPNHN1UEY5RjlRb255Wks4N3MvcW1Tbzh1TTdiSnArWEZhWkFy?=
 =?utf-8?B?TmJralIwRERkZm1TM1NYRlRBWS93amZsMmpXdXBpZ1JUTU85dDZkQnorOUJZ?=
 =?utf-8?B?clJKa3ZtQkxvc2dXWEN0dWpUdFMzUmhudmpZbXBBVzdqeGUxMU83enkyVzg4?=
 =?utf-8?B?Z3NsWVJqU2FWRnJGSTh0WkVsTmV5SERaYXNjL0RQUHFXRzFRZW1qMzJCSklV?=
 =?utf-8?B?Mml1TmYwR08rSlpKbnFOdHpOdmI0Q2pGSGJqNUQxUzN3VUszWmxiK3ZiN21P?=
 =?utf-8?B?N29qOXhNaW1XY09Wb0RUb1dHVEJ1RURMTytWa1dtbkRWZCtLMUpDckVFbXpV?=
 =?utf-8?B?eHRmaEwvSHppa3g4L1FVVUNsRDNueWljb1VDcGpPb3JYdFMxNWRETGFaUUlS?=
 =?utf-8?B?YW9mdWtXWHN1SjlRSUxFVmdtWW9QSVY0TlV1bkQ2cEFjOHk1T3VtMSsyZmEz?=
 =?utf-8?B?QU9vSDM5aEVFajRXK1Z3STFpSFVhYjVXdURMaGY3ZTM1MHlYbVpqK2hXOWhz?=
 =?utf-8?B?T05HSytqRUZXZ0toVTNyVklmYm1SMVNiU0I3N2pVNi9GUVFibWcvK0FVUFFt?=
 =?utf-8?B?eHNNZnJlT1g5aUhCbDZndndQK2dWSXFpOEMrT2VmQkRnaGJlb0owQU5wOTJs?=
 =?utf-8?B?Z0o3RFl1LzNuQ2xodmppSGlPVVY1TXA3SHhCUTRiYXdpa1VjcWhxMExlM0p6?=
 =?utf-8?B?d3VDREZPeTFoa1BYVFUybVBIMC80VFhkNC82RktzZDVZOUk5STRNTmlJdlh6?=
 =?utf-8?B?WDkxVHZybjhPOUpiSG9Ta3piMWJ1bGp3anM3ckg3cUZXekFBek0vWHNZL2dB?=
 =?utf-8?B?TTFNL0R0dnlLdE5YcHV6M0ZYRjdzcnF3UWN4U1Q5dWwvSEJFbUZKN2wxYXNG?=
 =?utf-8?B?dTBPVXNGUDU3ek1tbi9lM0xSN0dsZUx0dVpkT2MxTTdXNlNIZ1lCa1RncklS?=
 =?utf-8?B?aFZBUVhVQ2JWWFJrZTVoOXlhSEFBQlp2aW9pY2NhRnFiVGtDSjAyWlpaWDVv?=
 =?utf-8?B?cjlRaFp6V2RHZy8rbzhBb0ZmWlJ0Uk80dFBaZ2NCeDVEYXBUOGh0NDlHN2hX?=
 =?utf-8?B?VWVWTkVobVpNTnhhZEZBTlBJQS9uY3E4NzAzN1VLWUJZOFhsOXBhYkNoSUlq?=
 =?utf-8?B?c05mMW5LeFl6UUFGL0JVcDJWY1NjSHp1LzJhM3BxbzErZFZEb0QrNldsMlZQ?=
 =?utf-8?B?KzRJcnlYU0hTMkFzblNuUCtvUkFXQ2NrSDdSODd6aitPR3NjWWtqOUYzTDZP?=
 =?utf-8?B?NDJNekxDU0FzUldFN01OcjllNDhqWEpYZGoybW1GR2svZWtSbjUySlFoOW4x?=
 =?utf-8?B?aEpOTlhpTVpqVlpDMUZaTmp6Ujd0UldrMnZYbVdIaTFYRkthMER1dW1WOFp4?=
 =?utf-8?B?VDR1S0k2MUNRSjBpMlQzRSt0OVhQVm5iVXA3N2JoY1Jib2JqbjVhRWxvZDhS?=
 =?utf-8?B?Ry9QWUdTTVhyNmtQMFhmeHp5a0dNek5HeW1tNjlZaEZRQ2Zpb1BhZm9QYWxq?=
 =?utf-8?B?VHJRREFEZXJvNnYzUGZ6ZVY2bWJLSUw4ZVlUa3hxYWtITTdzUXMxTVBsamtY?=
 =?utf-8?B?QkgrTCtucTIrRXVtSDFFUGxiN2JHQkhvK211YnpweHFqRTRBTVo2Zz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: de0c8307-ab2d-4f4d-52ad-08de4dd5ba85
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 10:15:48.6928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhIU6y1myFq+BdtSpzbugRKRT+dy0FwocC4bsT4mI0zsBf2uvaFDayKzA2A1r+ZEtCZNJ7k6X/nmjG5ZUykhoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2051

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit ecbf60782662f0a388493685b85a645a0ba1613c ]

Fixes a hang thats triggered when MPV is run on a DCN401 dGPU:

mpv --hwdec=vaapi --vo=gpu --hwdec-codecs=all

and then enabling fullscreen playback (double click on the video)

The following calltrace will be seen:

[  181.843989] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  181.843997] #PF: supervisor instruction fetch in kernel mode
[  181.844003] #PF: error_code(0x0010) - not-present page
[  181.844009] PGD 0 P4D 0
[  181.844020] Oops: 0010 [#1] PREEMPT SMP NOPTI
[  181.844028] CPU: 6 PID: 1892 Comm: gnome-shell Tainted: G        W  OE      6.5.0-41-generic #41~22.04.2-Ubuntu
[  181.844038] Hardware name: System manufacturer System Product Name/CROSSHAIR VI HERO, BIOS 6302 10/23/2018
[  181.844044] RIP: 0010:0x0
[  181.844079] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  181.844084] RSP: 0018:ffffb593c2b8f7b0 EFLAGS: 00010246
[  181.844093] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
[  181.844099] RDX: ffffb593c2b8f804 RSI: ffffb593c2b8f7e0 RDI: ffff9e3c8e758400
[  181.844105] RBP: ffffb593c2b8f7b8 R08: ffffb593c2b8f9c8 R09: ffffb593c2b8f96c
[  181.844110] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb593c2b8f9c8
[  181.844115] R13: 0000000000000001 R14: ffff9e3c88000000 R15: 0000000000000005
[  181.844121] FS:  00007c6e323bb5c0(0000) GS:ffff9e3f85f80000(0000) knlGS:0000000000000000
[  181.844128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  181.844134] CR2: ffffffffffffffd6 CR3: 0000000140fbe000 CR4: 00000000003506e0
[  181.844141] Call Trace:
[  181.844146]  <TASK>
[  181.844153]  ? show_regs+0x6d/0x80
[  181.844167]  ? __die+0x24/0x80
[  181.844179]  ? page_fault_oops+0x99/0x1b0
[  181.844192]  ? do_user_addr_fault+0x31d/0x6b0
[  181.844204]  ? exc_page_fault+0x83/0x1b0
[  181.844216]  ? asm_exc_page_fault+0x27/0x30
[  181.844237]  dcn20_get_dcc_compression_cap+0x23/0x30 [amdgpu]
[  181.845115]  amdgpu_dm_plane_validate_dcc.constprop.0+0xe5/0x180 [amdgpu]
[  181.845985]  amdgpu_dm_plane_fill_plane_buffer_attributes+0x300/0x580 [amdgpu]
[  181.846848]  fill_dc_plane_info_and_addr+0x258/0x350 [amdgpu]
[  181.847734]  fill_dc_plane_attributes+0x162/0x350 [amdgpu]
[  181.848748]  dm_update_plane_state.constprop.0+0x4e3/0x6b0 [amdgpu]
[  181.849791]  ? dm_update_plane_state.constprop.0+0x4e3/0x6b0 [amdgpu]
[  181.850840]  amdgpu_dm_atomic_check+0xdfe/0x1760 [amdgpu]

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 294609557b73..e0daa4e051ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2179,10 +2179,11 @@ bool dcn20_get_dcc_compression_cap(const struct dc *dc,
 		const struct dc_dcc_surface_param *input,
 		struct dc_surface_dcc_cap *output)
 {
-	return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
-			dc->res_pool->hubbub,
-			input,
-			output);
+	if (dc->res_pool->hubbub->funcs->get_dcc_compression_cap)
+		return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
+			dc->res_pool->hubbub, input, output);
+
+	return false;
 }
 
 static void dcn20_destroy_resource_pool(struct resource_pool **pool)

---
base-commit: 5fa4793a2d2d70ad08b85387b41020f1fcc2d19e
change-id: 20260107-null_pointer-0bdcbe3461a9

Best regards,
--  
David Nyström <david.nystrom@est.tech>


