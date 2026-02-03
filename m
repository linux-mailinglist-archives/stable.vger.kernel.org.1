Return-Path: <stable+bounces-213250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ8sIyYFgmmYNgMAu9opvQ
	(envelope-from <stable+bounces-213250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:24:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A1BDA874
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD4CB309B45C
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78BE3A9018;
	Tue,  3 Feb 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="gCSb6y8m"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021082.outbound.protection.outlook.com [52.101.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B63A9606
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128649; cv=fail; b=ozzOKmtyhGZp4gDlV5Yx8Zkp5fIzYSqNVvO2EZQNSxiNWmgqvUMS+X0T1v9lXwJw9i4UBcg8f3NIwO3LoxvP9BGNvZBZ73u47x9+hONPPrHrFO7eP03VDsXt/X7I4H1DbWO5zarJvu6rJY5lONW0i+LQyp0KBljF6Q8r8Nt4b2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128649; c=relaxed/simple;
	bh=xgiU5Swm0Y5SkqIL4LWaToj6Xq49ouRttkBjseYuQXE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=YsqJQ4cyIA/bqhJnjBXKJOZkB6+Oslg5QG9Tj7prXceZFXaIsClzzFUOXlrjoeAUElgsMFcMDVMOOp6OQv91AnO/3hio2InRiKqevYgvSubxdYOSpdsKrZCKo4d+RUHTAQ2BZVVwXuEl/dCJuxXsp+MYL5MKyC/OqqoGeWRjKig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=gCSb6y8m; arc=fail smtp.client-ip=52.101.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwJO30v7hVgHqGj+Ut6fvtMAuuCveGW/tsR5ftIgWekqG6ajkRHJOiRoxOj4QCZpRzk+CmMF8Vlx2CvSaagRxG/rkW5fosd9rM+sNPa/AKzFBFin4+ELeCvgmw4Ai4m6ZKTPXNAGvdEfWrRvjqzsMCYofEhKnOcrbj+ebQIO6DuT9ZSjSdg1QlEIBewq8BNC+uX2uULz/pbi1KhuQfai3GQ+nGuJjahHEt2mXIzSQ1+oNsRamLmWq3AOvyylJqMI/nUNGOsgeJq028OiF9IX1KG0XQQkS4qmW2FMmEe6vpe6O9YtWQW2rDGn1swCBpug9tYcYW2f0PtwT/xrj4ABig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUKy/DhwwHSYfSupcOHmR9tUjfXNsreP8I6bQQkbYwI=;
 b=OLPL09vIRNA/iBQfSxqW+B0Z29oweUw+WrivGxj0RnuNuVCJYlF7OOE8+t6BFBsE2mR84leDVui/vy+dSnEj2/qxcXQRVFfWGxiQlU5SlyYXi1w6mi2rucmbHF4+tBIe80CWF8tybd5qX0pNNh2nsMk46H2fL5SzfnvS4Y9YckG5dErGDztP2oen4q5+4zRy8utE1oEv5sQgvtqsET9cLwXUD7nRHDEikglr6+8AlUby9J8WD32LrqYSB2/eyGxokWDe6JnZ5XkFoX7ZYqxPCXVAB8PG2d8zuFQBWhUfNWrZSXr53ghd+emxwe/HpuqmOyRsJzE7RwtyK3k4hKk9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUKy/DhwwHSYfSupcOHmR9tUjfXNsreP8I6bQQkbYwI=;
 b=gCSb6y8mQTrTb+fPc3hKHUnXM/U2Xk/Ri0LIIkgVBzHYtmt9MhURwxe3CcrvFzMFvEdkU9j/qrtZKxIwDx+n9NbCQ4IfffF0FcrXYJA+Eaer8sfofbe31Y5T18RcHI7jqNFX7/ll8UFOWey5Qiiwwf+acnhVvR1IhLLhfgRMwKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB1874.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 14:24:04 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:24:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 14:24:03 +0000
Message-Id: <DG5E8GQTEMKW.22FR0VWFCYIDE@garyguo.net>
Cc: <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] rust: kbuild: give `--config-path` to
 `rustfmt` in `.rsi`" failed to apply to 6.1-stable tree
From: "Gary Guo" <gary@garyguo.net>
To: <gregkh@linuxfoundation.org>, <ojeda@kernel.org>,
 <aliceryhl@google.com>, <gary@garyguo.net>, <nathan@kernel.org>
X-Mailer: aerc 0.21.0
References: <2026020314-retool-immobile-ceeb@gregkh>
In-Reply-To: <2026020314-retool-immobile-ceeb@gregkh>
X-ClientProxiedBy: LO2P265CA0475.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::31) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB1874:EE_
X-MS-Office365-Filtering-Correlation-Id: f83ea660-5796-4641-02f9-08de632fe213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2FEaVdXNzU0Uk1PNWpwNUw4OHV3UjAyWEgwRjQ5czdrdmpOVDZTa0xVZnYv?=
 =?utf-8?B?Q0JKWGdQWTdVM3h4QTltcTUyMjlxSC9ZRWtwOTZGNHBwWDBoQXJEVE4xNGFW?=
 =?utf-8?B?Rmc5b0tYeUw2eTVOdFcxaXdicWNGcXpNblI5NC92elUwK2tYejBzeUdQK3pN?=
 =?utf-8?B?L0VlK2lWaXBNcTZncmtkcnNHMGJmMEZlaThzL0lqRkVsRVJoUUEzc2NEUG13?=
 =?utf-8?B?ODlLSnc1MVQ2Tmg1dHJTdGtSeGhwNWE4Zm9HcmVzejFFcFNaMGpvTk5zT3pC?=
 =?utf-8?B?V2FNaDBBZVg1RUpDWW0yZURrUU5DZVVzLzVWWXVyWUZCTzJweGpjSzdHTGdT?=
 =?utf-8?B?OXR5MHllNXYzcDdLYXhFeEtFdmVSY2NPZXA1dEFNeVBNSGdqeWJFcW94KzBw?=
 =?utf-8?B?MXIzNFg4T3JFdnlwdldSdFJoTWRITkgvVkxXanpRNHhDNSswTnRiUW1aelBZ?=
 =?utf-8?B?UkZ5YTdzV3hLWGx0aERwWW5udmtLZDFMSmtHL1paekkzNUVPc0dxMVBuN3Uv?=
 =?utf-8?B?dFEyS1NQQ3dJTnNPZGZ4d280WDdHNS95UDk3akdDeW5JVEVHdzdsdENTUlFQ?=
 =?utf-8?B?emNZL0tEM2lOQU1CQThkT3NtTUh3bkJIU3ZGSzVHbzIzUGdHbFRHVC9xOEZO?=
 =?utf-8?B?WUNIM2RmVTBUdytUaUNGNmF1dzlMSmlUNEJOaFdzQWhpMVZVaS9qODNOVnFT?=
 =?utf-8?B?U0REVkVTNlU2K0NJUW82akJUbC9CQWxveWNXeU9iTTdOdmdXbzdMTUxKNjRh?=
 =?utf-8?B?NS9zUW1xTjdtbGh4M3RzMzlkUThLN3FXUWtuS0l1VWM2RFFEVlA1eVVCbmI5?=
 =?utf-8?B?amp5Q2lJMzduaisvVjFDdEVCc05LREwzdWEwY1NXOVdkR3BKMjhRL21VY0ZJ?=
 =?utf-8?B?VjgyNXFlaHBoeWllMnd2MEI2bStOYm1sd0VWclA4NUNYSm5xTDN3VDFDUCtn?=
 =?utf-8?B?NEJ6ekJUWGZYYjdHWG9RMzdrTE9KVEl4dTV2aHV0aFFFM0tGVlZNVk15cC8v?=
 =?utf-8?B?YVVmQTJFMWNLai81SmJaakZneXdvMHhDSTVuWG9wZVdOSmJXOElVNWN4NUwx?=
 =?utf-8?B?OXQvQmNWblJ3UWlKWjdNTll0OUFkRzROcGNJTm9JbE5NdzJYMDdUczZZSVVE?=
 =?utf-8?B?Y2VvM3R0Wk1BOFpCZU1ZZEs1bGhkeXRSUEFXQ2o0YitmQ1h6clFDV295N3U1?=
 =?utf-8?B?eENaeUNmNXJ0eHNPSmpxQ3FUUjFvTFZxSkNaRGVlcVdRb01HdFlsTzVlc05P?=
 =?utf-8?B?L01KSkJOTW9QVlV3bXRWRlVpRjdaejlwMEZiN1U4dFV1OHptbHk0Z1pVZ0U5?=
 =?utf-8?B?VmRwSVJ6RnE3QVY4YWpsNlIvdFhUWC9ub0Q4Mzc1b1pQSXdPdWNmb01pR016?=
 =?utf-8?B?RWlRVUtwNlJvRDNMc0dIWThhWDhjQmQ1aHJCeTU3MzV2RnVNaGVWdUVuWUlN?=
 =?utf-8?B?NjlJVUVyNlIwekhPQXBTRzM2UGV2WlpMRTJ5VWhzaWNZWW9LbVlxT1lzNjJP?=
 =?utf-8?B?MlEvcUlYTTArSGJzaWpvbDFaNSswMVdBOHdTRk96cmdYNkJFOGpFV2MzZEIz?=
 =?utf-8?B?aktqaVBLZ1ZGeEo1YUFwRFhQZUUxd3RoT0NUS0RpWnNsbXdtYTVzWVBjRVAr?=
 =?utf-8?B?SmhHZGlwRnhlU0RVeXdnMEhTTWlWSlB0V2xLMlZlcURmeE4xVWVTK2M0aUFD?=
 =?utf-8?B?Q2RiY2E2L29UdnVHbnpiK2NFTlJ6eTgrSHV3VkpUazJLSnlwWXF4MTRJY0xX?=
 =?utf-8?B?SVV3ZEJ2UGhUSmFkdnlOeUZ5Y3UwL1hiL1ozWXNnZlB6OTlPZmtwZlFPaWN4?=
 =?utf-8?B?Y29SZnFiTjArTCtocDlzTnByZXRpUitOR3phczgzRWVTT2N0Snh5Tmtobzhh?=
 =?utf-8?B?YldaU3ZKT3FMWUpHRzJidTY2SDZ6WE1SVndoU082VFJnTSttdE5oTzJJQ1Er?=
 =?utf-8?B?ai9ialhFckcwNjRTaXZKWngrNlB5eUJNZldxTlp1QzcxWWZOdEN0SVJTTXo4?=
 =?utf-8?B?TDk2em1iQXNSREtlVVlSSFNlUlFJK1E4dTBDbzQyTC90aGlPOG5OWDBIcE02?=
 =?utf-8?Q?gUuCVo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXFRZ1lsZTdTVHlsYk02RjJ4UCs0ZExaSDZ6OTJabzFnN3B3YnVpOXdYTHFB?=
 =?utf-8?B?WUVuaktpdFRZL0VNcDkvNTVYUEUwRjYvWGhkMmdPUjBVQ05kRm9uMDNyMEMy?=
 =?utf-8?B?aFNUUU1mR1haSTJ1NEJmbjQxdktEdnZscFI0NUI1dzZsZDZOVHpWbk5tVlR3?=
 =?utf-8?B?RkhmaXhLelN6dFN1RGgyRFZ5ejFDNXNONFBxY3lRcUhzSU1UWnFBQmNzaVJ2?=
 =?utf-8?B?eGxmeWVWOEFGamhxdHlpMVNieUt3anBEUTNKWUZSeUk3R1hpRWhQQjEyRGtE?=
 =?utf-8?B?UGNGVFdGcG9rdFQ4Zm1XbXBYR0MxZWREbWZlcG9lc0RYbThnZEtWRVlaVTFx?=
 =?utf-8?B?UmZKVCtxV1ZsRUU0NXZYZjJoWWJERkZidjl2TjNGQTRJK2VEMEFVOVJ1OTdl?=
 =?utf-8?B?SElWZGxSZTlENm1tQzdFT2s1QjBMRGljWlNWM2tsMEtodzYxNHcyRVZCVVYz?=
 =?utf-8?B?TTZkUjBWd3JCdmo0SUxLMzA1c1JZNG9EL3UrTWlqVU5QUzE4WU1QQTQzcXdJ?=
 =?utf-8?B?WWxWbmluV1FOWnBtWFc4aVk2Y2tscm0zVCtSRFNKNUx2ZjVUTG5lcEtCRGk0?=
 =?utf-8?B?ZDkrYWRscGRWbTJHOFVDVThySXQ4d2ZNb1ErYTVqSHh3cGxoa3d3SU95M2Zw?=
 =?utf-8?B?QUtPNVdkQ1Q1eTgwVUxJblFYcnY5b2NaOVd4eDUvdVlpb3F3Qy9DOUVuTjJG?=
 =?utf-8?B?Zm1TenZ2S3d1THk3S1QwMnZleFREMTkxUDZLcWV6Z1VhL0Vya1Nxd2J6UUdK?=
 =?utf-8?B?ZXB0cjY5NkhVWnVuWi9BRFd3bFlNcDBhbUQrOXNFUFdTQlJoRFArRVU1TldS?=
 =?utf-8?B?RmJrbzV4WDFZNkIrb1QwRnlvSThGWjRnbndjODUranNvbU0wTko1S2ZINW5I?=
 =?utf-8?B?NE4xSzB5Rkt1bmZJei9ma2RsdzJ0NDIxNEQ0cmdKSXQ0VVRvalErN1AzODNF?=
 =?utf-8?B?UC9MUnFURVZhSWZYUkN5dzBIVTVsWEVqRE1lRTJjMlFpY2RjaU1aTWxDajBQ?=
 =?utf-8?B?SnY3YlBNT0FnL0g1THJoSFA2cEhjOEJGVVF5bWVTS1dDczM3MmREc2dKUjZx?=
 =?utf-8?B?MHQrSTVBQ0dpZnRqNkNmU1hRZldReTU5TmNTNFQxcXpOZlBZajE3WXlkZzlU?=
 =?utf-8?B?MjA1YjBCeEs3eXZaT2plWkVzeG5jYmFHQjhia2ZQYzZDTFVRYkFLZjV1MGMw?=
 =?utf-8?B?bUdNalFzb3p0ZnBBSnlQcmlna3J0dFVQOTY4YTIyYUd0YWZjT2F5M0MzdHZG?=
 =?utf-8?B?V2wwNWt3NlUxQmVHb1J5blBmaFQrci96UXJTSk1qb05PcXl5WnBmd3ZBYTlV?=
 =?utf-8?B?OExxbXJ0T3UvVTBJdGx1YVM1NXVNV3FESTk1WWlMZ0UyU0paMFBncUpkVEdq?=
 =?utf-8?B?aXJ0azdUMlFOdFVtR2piRWhhK1gwVDB2VkUyd3hERDFRdWJUZFQ4TkdvY0c3?=
 =?utf-8?B?WG1NL1VZK0t3TjY0SU9iTE4wR0s5UHh6QTNob1pGblpVeG81WlRDSEZEalB4?=
 =?utf-8?B?eWZXT2FESXFXWkVUTzNFcG5PdnJJK3NCMmtmVTJBZ081cHE0SGx5ZWUwL0JT?=
 =?utf-8?B?TWpQK1lMQmFVSE8wV0NLOFpkL1B1bzlhOGJYdkVWMWRvWmZHU2JkR3F5eHp1?=
 =?utf-8?B?K3hwS2NLWENvUXBuczdhdGdiRWFsSmlGajRUbG5VUXdOTHNMdWtKL3oxMW9y?=
 =?utf-8?B?RFFFb2VHN1FtMHB6ZkVwN1FYS2R5Wi9McVF6c2xxOWJCY0t1T3NuYnh5Ukho?=
 =?utf-8?B?ZFRXYXN4V2IyWXRvNGxrdzJvbEg1Mm5HblRJOTNuUDQrYS8yUGQrblNJLzhB?=
 =?utf-8?B?ampBOUx4SjZWbi9HM0k3UnRIZkhKeWVPQjVhWGZZUkFYSTd4aCtZb05nTUZz?=
 =?utf-8?B?bHpGUnZDUFJCb1JNRExCTzJQS251bHoyTkQrUmp1czM0WDIyaEFkaUlUYmw1?=
 =?utf-8?B?VVRKYUV6NzZ6VmxRVVpDeEhhWUdpR3JtOXNQdHVrQXh5WGsxbGJpZGVzWmw3?=
 =?utf-8?B?UkgrNGpYbEhzUXJlZUhvZnRvVDdBKzgxYnlXMGFreko5bCt3M2RoVEVHcW54?=
 =?utf-8?B?OVhxemdUQ2Y0TFhDdFoxRlhtVk5US3o4clVKMzFZd0UxRFdReGR6Zk1TWHVO?=
 =?utf-8?B?YW5saUNFa09BYUVlUzc1LzVQOVJRSTFVZ3dESW9LOFBmNHduSW50cmRJMWtH?=
 =?utf-8?B?VThUcWhOV0g5MzZ4Z2xpRU1ISzJhcVhaMGtCU0MrR3NSbWNObFFGMUlEQnRM?=
 =?utf-8?B?R3M3a1UrZzNIa2gxUlhodWtmLzAvSy85c3hlTTlsbDdsU0ZxTHgyL2tWeDRj?=
 =?utf-8?B?T1hnZ2xwRTh4ZVgybVZoVmNLV0VHbFNmVkNVOTZKTDRJYjhtTnlSQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f83ea660-5796-4641-02f9-08de632fe213
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:24:04.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFLxBK60YbxqasQ6rhx52wQ9WPWmgedk7+nlH4lkOaOBUXUcnJm77Jj1gJ1eZzGYAmWyNSAxAlaoWLc8Cyt3Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1874
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213250-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 04A1BDA874
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 12:44 PM GMT, gregkh wrote:
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

"rsi" target is for development/debugging purpose so I think it's fine to l=
eave
it as is on 6.1 and there shouldn't be a need to create dedicated backport.

Best,
Gary

>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x af20ae33e7dd949f2e770198e74ac8f058cb299d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020314-=
retool-immobile-ceeb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From af20ae33e7dd949f2e770198e74ac8f058cb299d Mon Sep 17 00:00:00 2001
> From: Miguel Ojeda <ojeda@kernel.org>
> Date: Thu, 15 Jan 2026 19:38:32 +0100
> Subject: [PATCH] rust: kbuild: give `--config-path` to `rustfmt` in `.rsi=
`
>  target
>
> `rustfmt` is configured via the `.rustfmt.toml` file in the source tree,
> and we apply `rustfmt` to the macro expanded sources generated by the
> `.rsi` target.
>
> However, under an `O=3D` pointing to an external folder (i.e. not just
> a subdir), `rustfmt` will not find the file when checking the parent
> folders. Since the edition is configured in this file, this can lead to
> errors when it encounters newer syntax, e.g.
>
>     error: expected one of `!`, `.`, `::`, `;`, `?`, `where`, `{`, or an =
operator, found `"rust_minimal"`
>       --> samples/rust/rust_minimal.rsi:29:49
>        |
>     28 | impl ::kernel::ModuleMetadata for RustMinimal {
>        |                                               - while parsing th=
is item list starting here
>     29 |     const NAME: &'static ::kernel::str::CStr =3D c"rust_minimal"=
;
>        |                                                 ^^^^^^^^^^^^^^ e=
xpected one of 8 possible tokens
>     30 | }
>        | - the item list ends here
>        |
>        =3D note: you may be trying to write a c-string literal
>        =3D note: c-string literals require Rust 2021 or later
>        =3D help: pass `--edition 2024` to `rustc`
>        =3D note: for more on editions, read https://doc.rust-lang.org/edi=
tion-guide
>
> A workaround is to use `RUSTFMT=3Dn`, which is documented in the `Makefil=
e`
> help for cases where macro expanded source may happen to break `rustfmt`
> for other reasons, but this is not one of those cases.
>
> One solution would be to pass `--edition`, but we want `rustfmt` to
> use the entire configuration, even if currently we essentially use the
> default configuration.
>
> Thus explicitly give the path to the config file to `rustfmt` instead.
>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Link: https://patch.msgid.link/20260115183832.46595-1-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 5037f4715d74..0c838c467c76 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -356,7 +356,7 @@ $(obj)/%.o: $(obj)/%.rs FORCE
>  quiet_cmd_rustc_rsi_rs =3D $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>        cmd_rustc_rsi_rs =3D \
>  	$(rust_common_cmd) -Zunpretty=3Dexpanded $< >$@; \
> -	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@
> +	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) --config-path $(srctree)=
/.rustfmt.toml $@
> =20
>  $(obj)/%.rsi: $(obj)/%.rs FORCE
>  	+$(call if_changed_dep,rustc_rsi_rs)


