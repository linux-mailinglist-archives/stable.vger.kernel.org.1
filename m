Return-Path: <stable+bounces-211863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANQ1FM7qeGmHtwEAu9opvQ
	(envelope-from <stable+bounces-211863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:41:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BDA97E1B
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97367300E3C0
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486335CBA5;
	Tue, 27 Jan 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="dAd9S3lU"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022133.outbound.protection.outlook.com [52.101.101.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CF24293C;
	Tue, 27 Jan 2026 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532107; cv=fail; b=FX4mbvdMlhEPaQ56ldq4l2tidGqFqxsHp3YHZ71ZIQZqZj8tGrVkxNKPmlBaYhAIabRerx/Hcw6BPVRt5ifFtEapLL/qsHEjID6PyCt9DMlhr5ctsFFcRZAkkJkpG2Dhnar8KO2NEggFu8cvp65k7h9UA9IeTr684YVOpMUc9pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532107; c=relaxed/simple;
	bh=7WoFHOVOze1/O9IGEAOG70/wjscsJt/ptFdCQGAEPic=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=kJMqIWVk/dNEpAyeVblQiYH6nPxhT3EZ3/JG92VmiGFzyFmYnyC6YVnASlAa5PJ8DzbCsF9ueQaO9OGXMmNJYvJTaGMImUYquCpnIkqJZgvG9Pzp84VLUWV1JsybF/1sYgFo3osbOjF6UuP6sWgZTEQSHWVxp2wg1B3twTxbK3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=dAd9S3lU; arc=fail smtp.client-ip=52.101.101.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xuv6qt96recVwJ8VzgpTS7vHfVoD/m0V0l/gVQ4/9xsf3wk0yn97u64j38vjaO6qW6eHj+/UVBHD8nmYNMXDix4Kj4wnmDSXizCnnZcg3h7FlrrpU6vH6KoL+K4ZHouPN6oWA4p9PC64jbzXZYr3d2IvylFqisjfNjblLEVvrnN+8LzhqwcouHyjCJJcvtdsYuJQqaFtfCeiyf4XK2FW4Zj25MtmimvURl/oPYU5YAoaliPQRh7ZpEdDhBERRPYCv4PPR1m0tCNIkPWAOxdZGBgMmkNehUhcoUAdkFTXup+ZskCX99gGJNAGUrGO2FzDyt1o+DXKV2GXTFXgKjvt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Yt0eLa0/hnIFFKSZxRBiEYxCK2n4XyU5HZ7ZGfnSmo=;
 b=fwMAySnYqxzAeKGbVffod1tBkUxIbEJw2xBo6qhf5SVXrD9xyunWng+HNMy48MNJRLrr1CuB6skTSBYx8R5SykSsDy8NnLSapSiFILxupqKi4FsSz7uBqFFJyNFqyUB5m3X3XhGMB6jIuAs/WObt7UV/jH2aj64wIqDq+t5RTY02e49wzGTEgzLoWDrNwGwOlC8KDUaqQvwvkXbWwUj/C66rDBGMSfwpMcdXieWJ6RcMxI7yMkPQdmE/nrL3f/zKnF1itR077EZMWHVulmB2EgvKn1tsMbUivIDa+RGXtq3ktFX5YDbAbcXv1D5G1bj4wuT+6w3jKQm04Sw+oeZoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Yt0eLa0/hnIFFKSZxRBiEYxCK2n4XyU5HZ7ZGfnSmo=;
 b=dAd9S3lU3vX81wpPsLR+uCnUdWwDBPck2DtfVhosJQnqrhTrgC7GbOY6s6wTVji+pKZfNcTWtxPiTT589HmWT0mZ40djgfuqxS35mMh0Gf0lzRz0INHSzn9g08nin2ERAUqSoswHiEl9b8HQBbhx30nHbUKmgpkNfCZEZb17Yc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWLP265MB2210.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 16:41:42 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 16:41:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 16:41:40 +0000
Message-Id: <DFZIS0QDDD56.1ZB0WZUXPR5IZ@garyguo.net>
Cc: "Kees Cook" <kees@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2] scripts: generate_rust_analyzer.py: avoid FD leak
From: "Gary Guo" <gary@garyguo.net>
To: "Tamir Duberstein" <tamird@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Fiona Behrens" <me@kloenk.dev>,
 "Boris-Chengbiao Zhou" <bobo1239@web.de>
X-Mailer: aerc 0.21.0
References: <20260127-rust-analyzer-fd-leak-v2-1-1bb55b9b6822@kernel.org>
In-Reply-To: <20260127-rust-analyzer-fd-leak-v2-1-1bb55b9b6822@kernel.org>
X-ClientProxiedBy: LO4P123CA0278.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::13) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWLP265MB2210:EE_
X-MS-Office365-Filtering-Correlation-Id: 67885f52-f374-43f0-3c88-08de5dc2f317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFJZcTFYc3Q3eHA5ak9zRnpNRkY0YUJMbmdMckNuN040VzVLek04OGMwejZK?=
 =?utf-8?B?K1gvd2FDWXU0MitxajVxajIrOUViSklqYWhXdlpDT0tTKy9sc01PUVhLRElL?=
 =?utf-8?B?S01rMWtpZHNGdStnbUxjTmlWTm5Uc0xZaUl1bGNQTVF3enNsb3NrL2ZrcDl3?=
 =?utf-8?B?L2VFUUg0SzV4QUtCMS9tc09VSzQyaGQrL0lWcGcySCtsMGJsQ0pBbUVhOEtS?=
 =?utf-8?B?bzZTR3dBUnB6ZkpTTkNZRG5OUHE4RXRMRjBiMXpWdVgyVll0NTFaRkhWelZH?=
 =?utf-8?B?bjRvbmJ3b2NHZ2dPT3NQbTg1ak1OYmtLWnp6K1ZQNVFuRHBieGxTeWhzVWV0?=
 =?utf-8?B?OEovUURUWWh5M2Raam5QSmtjOC8wRytXTFk1cE5aNm8vVEFaUU9tNmMxeUFQ?=
 =?utf-8?B?aUpKTGh2djJCZWJBOWFHeURabmNhTnZ4WE1MdWV4YThFOUpRYVcyVVlVeUhw?=
 =?utf-8?B?UUFCTlI0ZEVFbEIyMUw4OU9GY3ZCR1VMYTZjUlVnOWkvK3dmU0VZZ1BZSDZE?=
 =?utf-8?B?ZDEwT3FSRzN4dFB4ZVEwMUpzZnErbXpLVlhvcU1SYld1dmZXK3BYdEY2bXdZ?=
 =?utf-8?B?Qk1GYUhMUlFPWlV0b29wSDFLQkNxVFVHNG95R3JlZDZOa2FwclAyOVdaVmhy?=
 =?utf-8?B?aGhGb0pYaFFvVzdIWTZSMlNhRTRXTzg3VURuN0lJa1ZHbTlWSHRLR3k2UzFJ?=
 =?utf-8?B?MDVDVWdSMFJDbVhCZXIrLzBEVUZ0cFpMbkxLbUdVQk9ITUFNWWVPcXpFZlBv?=
 =?utf-8?B?MlFNRDFKeGdRSjVSOFB1b0tMdFhDZStxWndOdEkwRkI0ZXZMYjBSMEVLeWxV?=
 =?utf-8?B?ejBqU2RTOEEwYkpJNkNCUkZjVWJrWm5kRitYQllEUGR3Wi8rRGVCb1E0Sk9r?=
 =?utf-8?B?MFRPMkZkTytaZGQvbEluNGt6ak03ODRrMlo1cENIU3ZyZDVVNld4Zk45KzNG?=
 =?utf-8?B?dktYbnQvd2tXYm51KzRGQ2s0em9DRHlQZVBWNzZPNitQVTl3Qll4dVNueElC?=
 =?utf-8?B?YkRlWGRmQ3UzMFpwY2NzQzAxdk1UTmt0UERoMkMvK2p3V3AwanFjTkxVTFZ6?=
 =?utf-8?B?NTNveEdJTlVqeFM3Ukx2VlRrTklJYXFVcnRuNnVlTnJLbGpob0pEKzE3ejZq?=
 =?utf-8?B?MHBaa1NCdHdFLzkvV3pSTTN3TzRwOEcyMFVxazBZZlZwbjhKUU5nWnhXSXlZ?=
 =?utf-8?B?SHdrOVhCeUF0MzA0Ulp5M0xSOThiU3V3U3h3WjFlZzgrZEt1Vk8vSzF3RERq?=
 =?utf-8?B?VHFzV2x2RUxDVXVQVXBXRVZ5Y0dBSS96T2VNYVpKVDFRR1hwcTJ2VDRBd2tp?=
 =?utf-8?B?S2VqV2p1Sm9RUFMwS0RsMWtrRTZ4bXRZMHU0RENEc0VKZFU0eHF5T205c2l4?=
 =?utf-8?B?VXpXUFlzME1MQmgxTlhHNXROdmc1YXVTZHB0VXVGYlY3TGRab1d4d0hzNk9v?=
 =?utf-8?B?aDUzcTV4L1lMV0VSYlFEMkVlZnpHQ0dEK1VzM1Mrc0krVEhpQ1ltdDF1Z2pD?=
 =?utf-8?B?dFNSQ0pLaC82N3QyaEMrVGt2a1lkMFIrV0VBYkZVV1dIUnZranBIRDhQQ2c1?=
 =?utf-8?B?R3ArNC9ndUkwM3VHQzJocm9WVFp2aC9FZjFIamZ0VkMxYmZ5bUZiWmRYTmJn?=
 =?utf-8?B?OWpZNHdKVVBYd2ZKazZFTERXSy9PRE42MUxZOXQrRkpmOUlHbmVQRHBXazN3?=
 =?utf-8?B?elJTVy9CU2xqbTluSERHckY5MmRjWUhKdnM1b2JRU1V3ZUZuUXBCWU5DYmRa?=
 =?utf-8?B?dm9Qb2pRcnhseEFZM3I2WFF1d09zM0xCbmF6eUlBcHVpL09vaE5IRHNrbCs2?=
 =?utf-8?B?NlJpYjdRMHFTMUdBYjJpbUtmTjc0djFabWxBakdGT2RudHpHODl3UlpHMEk4?=
 =?utf-8?B?eWg5cjNMSkp4b1dadjdTcThpL2ZRSmJJQ0VObkJaUVlyYjN5V1o1L0FMRS9J?=
 =?utf-8?B?aFcrS0tTRE9lVkpYdUpuMUFNOWlMWWJWWGpyQ0VMYnorOWRlSkFOcjJMUWNZ?=
 =?utf-8?B?djZjZnh5VG9VeUN3dzlINTNWWW5kd3NUMHA0TGRsMGtJTWNFYVN1a1N2dVho?=
 =?utf-8?B?WC93S08xdXJlNmZQWTNaZkRBSnBrOWxHRVFFY3gwQzJaNnRORVVFSjZkVDdV?=
 =?utf-8?Q?KP6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE5mY2Fid0RSSUZBNUduVjZGeXBWNVhQeFNVSlpZRnRCNFlXazIxak9qRE9S?=
 =?utf-8?B?L1JjamVBUS83Y09ySURid1BOTW1TWTZ2TkVZSFNXbmFFTW9VZGkyM1oybkZ2?=
 =?utf-8?B?VG0rQTVaaVhweDRRdHBaZFR5dnF2blA0V2xpcmsxSTEwcTl4OWNlUVNaQ2RR?=
 =?utf-8?B?NHp4NU0rMnBrWm9Tak1Kb2xHM3hIVVdGVmZjNEo3TnY1eU1TZ3VmdDN4Umpq?=
 =?utf-8?B?eWRQUGdtUHBpY1hVNXFEZnF4SDk3TnAxdFpUeENSSGloNjFFYkxTVUFCZXdF?=
 =?utf-8?B?UHdxYmJDcDZDbldKVTZxNnQ0S2JaRjUvYnVpQWpZaEV1WTQvekZOZlNQVlNy?=
 =?utf-8?B?Qm9YQTBZdW01ZHBTSklURXRlclJTT1pBeEwzY1puRDNESVc2Y2tIdXFURkxQ?=
 =?utf-8?B?QVpVQXR2bGNheXFmUGtKUS91ZWZ6UER4UnQvZTZLa1dtbU1iVzlLQ1FneHM0?=
 =?utf-8?B?cWdINEdDNmRvOGxESTZFTHIzUlBIeGRsblB2N0dSKzVtbWpkSG1hMUpmUFRX?=
 =?utf-8?B?Nk40ZTFORkVNdWlOZ2E0dHU0UGZKRFA3aDIrcDNmcjJpaGx1aGhlRlhpaWNH?=
 =?utf-8?B?UDFFalc2OU1wU2FCQjN1Qyt5ODNWdXF5RWtXdXJKWHh0MjUwQnNYY0xrVStL?=
 =?utf-8?B?SnFvU1pxL3VkWHIzMUx4RHlWNDdWQlJuSHFBQ3RhQmJhNjNZK3FObWNJTm8z?=
 =?utf-8?B?SDQ5dHB5QkIySjA2VWFJT0llbDVINXhjc0hXL09zYjhFbkdLWGtQRm5ZTmt0?=
 =?utf-8?B?V3BMeE0yQ0M0d0lyY25ZMHkveWZ0M0cwRDB6OENXamhDMC9HTzFNZ002ZW9M?=
 =?utf-8?B?cnRtZ3l1b0EzR3Y1ck1EQjRPUlFvNkRvdGo0cm5SYTd6M0YyQ0JpK1lGMlhv?=
 =?utf-8?B?SjkvZ3ZmMVV3YUthcXUzTHB0aGJBVzVQcmdGZ25uRDBpZFlmWU1GQWpDVjI5?=
 =?utf-8?B?QUg3QXdOa0hVT2RuYTRMNUZFUmF3ZnhQaElhTkJSMXl6ZklqT0YzTENEV3Vj?=
 =?utf-8?B?cGswVnNLVVdVb3V0L3pyV1lpa3ByZnBSbHQ4SkJlYWVYQ01tWWxaaGdVZGRh?=
 =?utf-8?B?ODNndXFzR0V3ZTBnZ2p2NVdOVmFjZE53QitYWWpvbHA1YnNodjZNR2pxOUpW?=
 =?utf-8?B?UE5OQkdEV3Z4bmhJVEdvMCtkNEtOZmRtcjREZis0MGZJVTFhcUpEM1ZKdjFJ?=
 =?utf-8?B?Vk12QTNJU2dBNEhiMXhiTVAwdk9DZ3B2dDVmdm0yMExnWGh1Q2czNmhxdU1O?=
 =?utf-8?B?SGFYYzZBTXNvOEFxOHkrL0lMQ1UzdmNVckJpTVRPakV5Z2k3OU1tbWo0NmRU?=
 =?utf-8?B?ZnROcElCSEwwK3JFM3Iya2xHNXYzZzYxa2tpSTFnbzF1VWx0M2twQlpuQ05m?=
 =?utf-8?B?Q0I4RkFWei9TU2JveEJ2SVFSdFp6TzhKTGF5bnJtWFR1Nm14V1dYSCt6NU0r?=
 =?utf-8?B?MFlrK21sN2RYWnJuUWlURjMwM25DNFBNMmZkZndBaE5uK3UzbmtJdkVRUHls?=
 =?utf-8?B?dnR4SEdndS9VWGlCTDRFZHdHR2lMV05BU21YUE5IazhYQjZCc3V1WXZFL1FV?=
 =?utf-8?B?Si9oV3JCQU9HeVhaZVh6QTBzeVZEVlBHQkdUcCtPQUU4NDlBd1pySE5lbGZh?=
 =?utf-8?B?RG5Lc0pnai9sRlJVVUZVQUZXbjEwUVQ1MmpwYWdiZDlIbjNucmlRQTRhTXdk?=
 =?utf-8?B?TU0yUkJVMWUyR1IxMHMxZk9iMjRHMnZNQjNCN2w5Q0MrMGRST1FFV1YwaDlK?=
 =?utf-8?B?NjF1T2twN3YvN0RTMUMrRTY4VG5iMEpTMFVRRnFQZkE3OStNb1FFeG1INkdj?=
 =?utf-8?B?ZGt3RnZMbk4zS1ArNWhia21nNDVySHBNL1BvdllLY21NYngzT1BnK3ZLcE9P?=
 =?utf-8?B?K3JzMnNqVjJQL0IyNE45ekpLVkxqeGd1SkZnaTEwWGR2ek9hQTgwQVhxVzJX?=
 =?utf-8?B?ZjFsOVVFdWJ5N3paYldydnpxeGhuYVMveTVSQytIUmxUcDJLVDA1elJ2c2dD?=
 =?utf-8?B?TnhwT0pKTDZITU1rakl0VXdGL1NwcGtmYU1iSEJvRm5TeWhyZ25BUGh1Z0tZ?=
 =?utf-8?B?d1dsV09hek5DUmxLYXZuL3ZvbjIwUS9kNUJoMWJlcGE1dktxYkZLWlBqNkpp?=
 =?utf-8?B?aTRmaHZ2SlNZOU1SZS9xNnNldWlGYVNZL0l0ek1wc3FTYngvcTM4bWp5YUhK?=
 =?utf-8?B?QituVnpnMk1iUStIeGpYWDlKYmZrb1lZMkxXK3hZSi91V1o0Y3JHcHkzaCtw?=
 =?utf-8?B?cUUxemRGWDRQMStReVpTRDJJQlIwQzY4ZENhUFRFQ2pCcllYTnN1NDQzNnZU?=
 =?utf-8?B?aDRleUFMZ3FTTnh5NTlJSEZQLy9JZUxJYWhwU0JxM0NvTXVYbWdHdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 67885f52-f374-43f0-3c88-08de5dc2f317
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 16:41:41.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fuWxw77w2KpUxOUAyT5T+hZCFby6OXzTbrDlLYuOD41K5duDmcvG/0ychIoZD3f069byuEB6JILZL7YejIBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2210
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211863-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,kloenk.dev,web.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,kloenk.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,umich.edu:email,msgid.link:url,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: A0BDA97E1B
X-Rspamd-Action: no action

On Tue Jan 27, 2026 at 4:35 PM GMT, Tamir Duberstein wrote:
> Use `pathlib.Path.read_text()` to avoid leaking file descriptors.
>
> Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> Cc: stable@vger.kernel.org
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
> Changes in v2:
> - Use pathlib.Path.read_text. (Levi Zim)
> - Drop errant Tested-by tag. (Miguel Ojeda)
> - Link to v1: https://patch.msgid.link/20260122-rust-analyzer-fd-leak-v1-=
1-945577813b20@kernel.org
> ---
>  scripts/generate_rust_analyzer.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_an=
alyzer.py
> index 3b645da90092..152bd3705303 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -190,9 +190,10 @@ def generate_crates(srctree, objtree, sysroot_src, e=
xternal_src, cfgs, core_edit
> =20
>      def is_root_crate(build_file, target):
>          try:
> -            return f"{target}.o" in open(build_file).read()
> +            contents =3D build_file.read_text()

Couldn't this just be

    return f"{target.o}" in build_file.read_text()

?

Best,
Gary

>          except FileNotFoundError:
>              return False
> +        return f"{target}.o" in contents
> =20
>      # Then, the rest outside of `rust/`.
>      #
>
> ---
> base-commit: 2af6ad09fc7dfe9b3610100983cccf16998bf34d
> change-id: 20260122-rust-analyzer-fd-leak-b247830d666e
>
> Best regards,
> -- =20
> Tamir Duberstein <tamird@kernel.org>


