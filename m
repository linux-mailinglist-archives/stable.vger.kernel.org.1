Return-Path: <stable+bounces-188203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74079BF2910
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4113C4EA306
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751C732F770;
	Mon, 20 Oct 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tIhGI/2x"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013057.outbound.protection.outlook.com [40.93.196.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6433A227EA8
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979537; cv=fail; b=TTsw/hGyZeCWKQK0YNBb5/sycr3+ie1dGRqq6YTCcM36nSS7PRSR+7LlQwBhvkGmeelZacLwVsHC+FqZKBeukLj0xEGE/4RBKqgOwahU3shIVvfBz3OttxyX2hZLU4SheCDvrWAcSVTyds26RAsaFuIy6Os8v5G2ZehBhV1IaPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979537; c=relaxed/simple;
	bh=9oi++jAuiwuY4EBLojscsdQWwiDKPnIEauTE2e5l5o4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CoAUdg6+m4jL+my1i64/G0ArJU6frrH+bZhZM1my62R/e4t6+FeB9mjboQ1pyXxBExETRvDnD83w9vP41qGty8kPrivnk6XSbKAGl3hFh8VoRUGzxLjgF2kRm1VWajdmZs6vG4wpSxCFC328mFeIBU+1gA8EvuAVIAWmOBjmbx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tIhGI/2x; arc=fail smtp.client-ip=40.93.196.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZWD/99Vtzx7rh0CdDnlS4lsCTG8rkYQHIuwB+ZpMLwzmNx7qvW6xpV3P/N2/J59YzGmT8fjz+6qoPAKPLLa1PnwOYRTdzWnupabdPjWjGt1cKtcLy3GphBiahX32Ht6H0GJKEjjN1BGe3q8qMQKjna9pinJFqks/YBs4Y6u9vGPda4x3s5TPkrgJBWzS6AsBYV0lKLBUCcLD3U7pEBDCbeZdQwYcYs2lv7buid0l2TKTDg0keskrjFJA8eW+4ECEH0OoFuUB39e61ZpUOLsKS7dQ4SZ/bUlXuSyoXEmg/LLULZRjmfB96NZ+wV5nmMke1XnuogWV53OaNHks+zf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vycs7Lwo1Xl6x1jvlgnezzT+25b/n5d7ZchadrY6+ng=;
 b=juJ18JS6oyCSzdUrRKX4JeS/SINb0yg3bta0/Gex+/w0YQutYU/dUiDeOAFpdNAy2XgiO2I0Y8jVqpMbKMlfhdVbDf23HexIsTLttQWmCW9KKTHXv5dSr967ZYIYDyNb38vvNnl/C9fft0d/Z8G8zVuDX/NeYCaDdAM1iG1Gaua4L8jrnvdfbEdXJvKT53u+BdI/G9qkKKzfI5U3Aj5qENU/s3eL5tkxN3K/9X30pnQulrRbpg/eMzaSBfd/UbEsFMWSirjH8mWLmN7XIoL49sPxMP/8BL3E+mJaRqFR+/TagrfRS0K/mFnRD7LgZIYX+Xgpv3S0vSiN8x3usN8MDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vycs7Lwo1Xl6x1jvlgnezzT+25b/n5d7ZchadrY6+ng=;
 b=tIhGI/2x8t4/7lpBnNA84tMrt90fYWYjItgMMji6FddbJoIPLRr2rcQaR4XmXK/m7rO4sWf4GvoPwomCpdtzrtBo9Wb9TLjTkGxtBTgDvwjdujyk9sHr+9C2c8RXreomc+QU1kQ1789PJwdNC0fJvAxL6PtTSk4w2Fl36VsDv3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH1PPF6D0742E7B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::613) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 16:58:52 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 16:58:51 +0000
Message-ID: <9fc2ca88-3e9b-4751-8827-268f84fd2c6c@amd.com>
Date: Mon, 20 Oct 2025 11:58:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17.y] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously unavailable RMID
To: Babu Moger <babu.moger@amd.com>, stable@vger.kernel.org, sashal@kernel.org
References: <2025102047-tissue-surplus-ff35@gregkh>
 <20251020162121.43543-1-babu.moger@amd.com>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <20251020162121.43543-1-babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::9) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: 273797f2-50db-49d2-f858-08de0ff9f1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aURONklLRTF3a2pwSG5zTVFheFFvMjM3UWNmUEQ4S0NpWWxXTkxtZy91MnNS?=
 =?utf-8?B?YWNZRHMvemEwSDFRZ0VsSkxqNFpLN3h2YThIQm5kaGxZVmgva2NtSFVvaktl?=
 =?utf-8?B?YXBCUHR1UlhScWFYM0RPempoQXplYktwblpqaVVRSDlWU1EwRnVpMVh4UHla?=
 =?utf-8?B?Ykg1NE9RRnVXQzJFQ0o3Z0h0K3pLR3BIdFhXSFNNYnB4Y1crMXdiczZUT1Zq?=
 =?utf-8?B?K01EV2dqWUswYnF0TGpwRWNIM1E5N0JubFhuTVltaWtKUEZBU3N6SXk1KzVM?=
 =?utf-8?B?T0NFWmFSU2prcXdJRERNQlZvNDRNMVF5U0ZLcm4xYzlxdU1XaTZWRVJ5MWtN?=
 =?utf-8?B?MGlDZDl1SDJJazFIajlmQTdPWlpGcmRDalA4Z1JjWnMzZzcrRWZ0UkhsYUdv?=
 =?utf-8?B?Ym11V21OdkxtYzJGV01JZUFhc1dqMmR4eGtJYkpOWUJvalMyRjNoY2hTT1FD?=
 =?utf-8?B?Q2ZBbDRXYk1qcTU5VGNMT3JWeEtBdkxRenhLV2hwS0I1RjQwS2FFNWxVa3JF?=
 =?utf-8?B?blZDdUxHb0NKNDFIczlrRlhmT3hDbUl6d1pvSTZGM1JwUk5xM2Y4dS9WZ29u?=
 =?utf-8?B?S3B3Qm14ODZCOEZNK0VpMUozS040cHh1a05qdU05SjJxTjVOdTQ5dXU5Vm1R?=
 =?utf-8?B?UFY1MkNqWXU0ZlU4T2pYUllaam50YkdIc3BSVzY3bVZHZDJrNkNEck1adDg0?=
 =?utf-8?B?ajZNOEU4dG1FSDhiSWViNmVDanJvTjQzNWdCQ2tWaktMVDlNOGZWMEF0aFRz?=
 =?utf-8?B?VWtwSzlaUER3bkxMeFNMY0VFcmZnT1dXQ0l3R2x6MmlBblN2ZjJkR2xyMjBo?=
 =?utf-8?B?eGxCT2xMcXpxeTFVcG9MeE9TMENEb2ZadEc1SEYvektMRWtlUk16R2xDMHEz?=
 =?utf-8?B?WVE2ZThpdlo2ckxmY0RyV1h4UEh1N0ZQckVuMTNoVnI3dUpGZzdITVpmcklv?=
 =?utf-8?B?WWFLMVg5TWVIdTR0N3A3emY1Q0kwYndFOEppREpsQnVVNUJSdWx1ekdVK3lY?=
 =?utf-8?B?TzF6TFlWQjdUMEsydTZjQ3dTQTlObndOODA3RGUyYWlxbWNxRzNzZUNiS05y?=
 =?utf-8?B?eWhCVHU1dXNrNmpHTXF0b2ZUNzdxUVRkWFk1Y1lLVVV1TDZlNUFQd2ZzY3NL?=
 =?utf-8?B?d2twMG0xcTRYVml2cU9LdXBYcW4vZUFRTG9iNHJicDlId1VxUTByZVAzOHh5?=
 =?utf-8?B?WXNOUC9LdHBQSGxsYjFVcUNXTkFjMFJ6MU5GQ2lycGNXRXhDRDlwK1Q2anZ5?=
 =?utf-8?B?L25ieFVHRmVuOHFlMWVOd0RhdVlGTlhpelBQbE43VG13WmdpbXdUZDdWSVBh?=
 =?utf-8?B?TktYSVU4TlM1cDVjTEF0aEE4TjVGaTVLZWR5S29BMjh2bTlXNDFiOU1sY0lP?=
 =?utf-8?B?YkhocUIycmhWL1pQZTh4ekh4Njh6N3Q4ZU90aFVHUGJlMldKTER4MHBIcmkw?=
 =?utf-8?B?N1NWT1FBNXNvY3h4cGZkMkYrMWdkZlpiSUc2WnFyTWxIVy9EQ2lmc1RySHhC?=
 =?utf-8?B?UWQySDNMM3B2M1RlOUxiMWpsVXpDUkVmQkJVZnlkdk9KMlBPK1daZDNOWkVx?=
 =?utf-8?B?c3UweUNKbTFOdXk1RVNqbVhYUVFtRWVWK0tKT1ZLZkdJbjNUeVNpRVozYjBF?=
 =?utf-8?B?azFQR2JQMW1KdGhZUVRUTVJEVWtVanozOHBwYmdhcXdjVW1oUXVzS0N4OUZw?=
 =?utf-8?B?LzJvUVN2eUpDZ3djRERobHUxMTVFaGJhSGt2YXdsSVZuYktYaDdlbUxHSlIz?=
 =?utf-8?B?SVFlNW05eXpOZ3dLaW1mQ1hIVC9HQ2pjZUdzdFVGendqZFN6SEFSSkMxWlJn?=
 =?utf-8?B?aGFSU21jUTljR29YcGRpODJSN3JVNjh0M05IRFRLYkxYTzlSQlZRNGlFcmhP?=
 =?utf-8?B?b0NjNVQ5Q1ovM0c2SEpaTnJOZFZCMHNLbk50c213NDVQZWVVY2dxQ0VwTnNv?=
 =?utf-8?B?TWtSODlDSWRjWEMvbjgydXFzTGJCYXlzekFGL01EcWpDV0cvcXlFb2E1b2ly?=
 =?utf-8?B?eFpHUVNYZ3d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzFmWU15ajRLYWVuKzRDTWVHUDVpaTZXeHJzQlErLzZ4ZDVNd0hXbDVWTkwy?=
 =?utf-8?B?VWhvdHBPZkwycnlJMFRaa0VhaTZ6L3FWc3lUMiszZWdZaHFTUFRvcmJ0eEg5?=
 =?utf-8?B?cElRSVFsRmRuQnJ6eTROZU80aGNyWTk5aWFudkpQcmxVa1NEMWszMlNLK2J1?=
 =?utf-8?B?ZGtPc3NxSERjc0Q5TWNDQkQ3ZWZSOHJDdGVJNE0xOHpkVVg5Q04yeHV2ZFhp?=
 =?utf-8?B?aXdIdFhlK1lZODN3aVJHT3VvdHdERVZTQmR0WTRvTmVnMTdKalZia1FibWli?=
 =?utf-8?B?aWxyK284cHJOdVZtU1RjRnEzeWNCOFhiSjl6N3VtQlJGaDIzUGFFTlNZK2t4?=
 =?utf-8?B?RDFjMWpBM2NYRjYrN0RTdzlmNnFzenFVMUExS3ZyeVZTUFBWUzZTdWxGdk5L?=
 =?utf-8?B?RmlidUd1VHRBNGU1TCtCc0dVZDAwN0JZMmRKQ0toOG0xSkpwb3pNYTZxakhn?=
 =?utf-8?B?R1VxYkNaMWFNaHpzZHh4ZHdGaXhyUy9BWTJpRThQSHF2MTdjU1dRajVNbEF0?=
 =?utf-8?B?RHkvUkhHOVkrME9uQVZGMlV5Q09wcndoUGx6cUdCMkZvdmdYTmlZeE16M1pl?=
 =?utf-8?B?RWJoYlliU3RRNWRhRmhGbWFTbDltanVmU2JyWER2SzZsb2FCellMYkZVcSsv?=
 =?utf-8?B?Rnk0MW5kS3grVWZaUkR5c0lVUkpiVWdkSEpDUHFxSDQ0RGQ1Q0lVc3hSNW5P?=
 =?utf-8?B?OS9mZTVWaTFjOU5WamFaOGJxeHRoWlBjbUNZRnVUVEdySWZkbmdZaGN4bGxL?=
 =?utf-8?B?QldsUE1aU0xPd3M5QUpNUTl0bG9wM3ppYVdXajlLaGo0a2dNTVVidklhQVRC?=
 =?utf-8?B?b0djTmJvSkM0bGw5MTZYS3hROTV1WUF6UmNkbDRzd1EvM0ZVOWR1dFlNOE9w?=
 =?utf-8?B?WmxaclQwN0ZFZGVHdE1SYUhEa1hVN3JNL0x5aWtxMjdYUVM4TU4zc3hVd1Jo?=
 =?utf-8?B?S3o4MXlaUHc5YUMrRTE5YUQwT2dlZDdiZkM5V2U1dFJPSEtyckVtTjBmUEpD?=
 =?utf-8?B?R2cwUUFuZGxJMVd2ME94ektHMlFrbHRnVU1QUlRLS21iOXpEYkpkbGlkZ0FD?=
 =?utf-8?B?eHQ2MW0rUmpWWUZLaDVvTXlEclV3NDM0UURiYXVCa0ZMZ3lsT3RYb1k2RDZC?=
 =?utf-8?B?SUxaZGFMRTZVRHdkVUYzYVBPWGRNZmhNNjJ2M252VnJEblR0VGFjS3BreXBL?=
 =?utf-8?B?YVNjVTN6UUgwYUliM0lsemdGNzUvYkpzS2ZRRDdDTnBQTWV4elc0a0luZkhj?=
 =?utf-8?B?TUZPUC8yZlpBamkrKzBsNzZOU0g0YmtpSmYvQmlvbkdjdTZMRi9wL2dYRnVs?=
 =?utf-8?B?c0dUVWJsZnZ4THlsUjA0eWI4RnlTT1VJVTN3V0NjbFN0Kzd5TWtnMi95L1V6?=
 =?utf-8?B?VzFPWE1MTTZ6NCtZNGo5bEtNcFYwVFhHVW1GMUVCYlF4Wjg2dG9Eb05NNThw?=
 =?utf-8?B?Mk12aGtINDFFeWVCOHpoQUpsSU1jZWNwWFh1cjZTdEpmS0NiMmVTWlo1QkhX?=
 =?utf-8?B?YzhWd09VRXJoN2RqWUt1R093VmVubkVvaWJvWVRJaDlXWDJjbllqYXhvNVc3?=
 =?utf-8?B?L01DTzlFbTNqZTNya2VSbHlyNzczUkJXMWxsUE9UTHZvVnZKR2d2ZThQU05Y?=
 =?utf-8?B?eURBTktTM0pDTEZhejIzK1Vlc3loY04vRlc3NkF5anQrSGdrM0pkOTllRzh3?=
 =?utf-8?B?RFBsL3cwVHhxamU2bmhrRWFIeldtWS9iY0MrL1hGc3VVZ2t1NzRuUmVkYnhy?=
 =?utf-8?B?LzJFUHVneWh1NitWc25rQ0pHeitRYlNxZ3BrcjJXUUdQN0Z2WWR4cE05VXZX?=
 =?utf-8?B?dm9JN001YWtIT3IzUG1NV3lKWnowUkZjaW0ySXpGVndLN3NpdHU1S0MraUYx?=
 =?utf-8?B?MWg2OHB1Z2N2MEY5eC9GY3lCUitZNFIyTVI0azhPTWxIcXExYXp2WVZRMGlI?=
 =?utf-8?B?Qk4ybW1TV056OXFmYUg1eXA2NDcvcXJJYzlINHlyYXhLaDE1dW1GT3JwQ3FL?=
 =?utf-8?B?R1NPMm5zemRSN1ZGZ09nL2h5SkpNaUJtd0xMc2hDOTdwcFhOd0k2R1lYek9r?=
 =?utf-8?B?TTFFWDhSWEM4T2hIOXV3L2JWY2psUTdBZ3FiaU1rSHVvOTc5am5qQXhFaklr?=
 =?utf-8?Q?gbyY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273797f2-50db-49d2-f858-08de0ff9f1f0
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:58:51.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maT/dYXXki/mAj3fezPOfRhC+1jRR1KZzGnC7pzV35/InMVamG5QFFmEU/Zn7CPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B

Please ignore this patch.

I see Sasha Levin is back-porting these patches himself.


On 10/20/25 11:21, Babu Moger wrote:
> Users can create as many monitoring groups as the number of RMIDs supported
> by the hardware. However, on AMD systems, only a limited number of RMIDs
> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
> this limit are placed in an "Unavailable" state.
>
> When a bandwidth counter is read for such an RMID, the hardware sets
> MSR_IA32_QM_CTR.Unavailable (bit 62). When such an RMID starts being tracked
> again the hardware counter is reset to zero. MSR_IA32_QM_CTR.Unavailable
> remains set on first read after tracking re-starts and is clear on all
> subsequent reads as long as the RMID is tracked.
>
> resctrl miscounts the bandwidth events after an RMID transitions from the
> "Unavailable" state back to being tracked. This happens because when the
> hardware starts counting again after resetting the counter to zero, resctrl
> in turn compares the new count against the counter value stored from the
> previous time the RMID was tracked.
>
> This results in resctrl computing an event value that is either undercounting
> (when new counter is more than stored counter) or a mistaken overflow (when
> new counter is less than stored counter).
>
> Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
> zero whenever the RMID is in the "Unavailable" state to ensure accurate
> counting after the RMID resets to zero when it starts to be tracked again.
>
> Example scenario that results in mistaken overflow
> ==================================================
> 1. The resctrl filesystem is mounted, and a task is assigned to a
>     monitoring group.
>
>     $mount -t resctrl resctrl /sys/fs/resctrl
>     $mkdir /sys/fs/resctrl/mon_groups/test1/
>     $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
>
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     21323            <- Total bytes on domain 0
>     "Unavailable"    <- Total bytes on domain 1
>
>     Task is running on domain 0. Counter on domain 1 is "Unavailable".
>
> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>     counter starts incrementing on domain 1.
>
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     7345357          <- Total bytes on domain 0
>     4545             <- Total bytes on domain 1
>
> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>     state because the task is no longer executing in that domain.
>
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     "Unavailable"    <- Total bytes on domain 0
>     434341           <- Total bytes on domain 1
>
> 4.  Since the task continues to migrate between domains, it may eventually
>      return to domain 0.
>
>      $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>      17592178699059  <- Overflow on domain 0
>      3232332         <- Total bytes on domain 1
>
> In this case, the RMID on domain 0 transitions from "Unavailable" state to
> active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
> the counter is read and begins tracking the RMID counting from 0.
>
> Subsequent reads succeed but return a value smaller than the previously
> saved MSR value (7345357). Consequently, the resctrl's overflow logic is
> triggered, it compares the previous value (7345357) with the new, smaller
> value and incorrectly interprets this as a counter overflow, adding a large
> delta.
>
> In reality, this is a false positive: the counter did not overflow but was
> simply reset when the RMID transitioned from "Unavailable" back to active
> state.
>
> Here is the text from APM [1] available from [2].
>
> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
> first QM_CTR read when it begins tracking an RMID that it was not
> previously tracking. The U bit will be zero for all subsequent reads from
> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
> read with the U bit set when that RMID is in use by a processor can be
> considered 0 when calculating the difference with a subsequent read."
>
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>      Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>      Bandwidth (MBM).
>
>    [ bp: Split commit message into smaller paragraph chunks for better
>      consumption. ]
>
> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> (cherry picked from commit 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92)
> [babu.moger@amd.com: Fix conflict for v6.17 stable]
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c261558276cd..8e0c28b34528 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -238,12 +238,15 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>   
>   	resctrl_arch_rmid_read_context_check();
>   
> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>   	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
>   	ret = __rmid_read_phys(prmid, eventid, &msr_val);
> -	if (ret)
> +	if (ret) {
> +		if (am && (ret == -EINVAL))
> +			am->prev_msr = 0;
>   		return ret;
> +	}
>   
> -	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>   	if (am) {
>   		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>   						 hw_res->mbm_width);

