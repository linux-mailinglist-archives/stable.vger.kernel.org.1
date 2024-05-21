Return-Path: <stable+bounces-45495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC18CACA4
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562661F22940
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85174745EF;
	Tue, 21 May 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJRmu4sl"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18297353F;
	Tue, 21 May 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288634; cv=fail; b=uUGthX1vtcQWr7s5bWIPFJwRBUu1T1nFPh20vUZwa+Lx23IjVjffsAvd4s+sSEzSRCnV3GD/fbL0ffmsPL1Y1StPVxDNGUP8mPn00TkfFdnUkjGMY7Wh+bSjr0Sz6kRxO2Bgik47yfoip0cno8SxOd/t+hsQE/NolyiC84WLeY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288634; c=relaxed/simple;
	bh=i6AAUfUc9ShIGlAcNt2PjQKn0WqP3YNWWk/Bl4brhjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VBE9rqfwuPqOKunNWPfB1qkUSQGi/V3tvGirfD+fMQgwXEkUZLv6d1rYIPf/JbBRvWPze4EUNOEIEqa2x+JsgcKutJmk9WVlo5aMqd/4nczwfJZNdC2LwWyUsuH4q/JE0at44L3UvDa6+cJd58p4gy/+ws6LibW/yCRumuspcEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJRmu4sl; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKoveyQPWUoFlUm+RWDeVKYPT990qo26Q6S597yEa/TM1lW9z+sbeVYwgpgGex+0iMSCTLVdAIFRa50DlncgHA8TJnuW8irhr09F2WP1m6BKuqkSHfPz0OorgFBjTHV4/sT06jXvNFzIcEMNebPqsbnAfuet+4Tlu4obxgjOSa37qwHDJv+Bo74P3RrECgbqZx8JVi3X0Iydk4ljGwibkg4ZOBxKqLuN3g1YxwqvBPVM4BGK+8mHK2zJdDKZUyVtRCj9RlqiumwZ79KhUZq93L44eg56K2Fba5jzplQZJ2wswiRd1jE+Og3AwuKy/5WIeJyo/B+xei84BoW+f5oORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbA9ikWOn3+DIOrybZA/FX5cdsLJ2m5Uz2Ut7wquqFo=;
 b=ZplKVdUr62tgt0JjD5j7NBPS69WP54hUTti2b/ZcZSg3Nw9ktwMl667yHu4/Rd4RDZdiHLognLV9hegK/NNqgbr8euJTQyo6kIwG8+JO4bfVaLigk9VtloXHZs06sgJhDNgnMp2AYQ2GRou6egSekcmVeQCcEepOFoGRe8guO3Re2wbsz1rgdvLtvT87XKAUddRawHUGmZ7Mh8W5hDe94eH5ozEzICyCcmxOJAJMfIWM6vt4NXzcJasYpvh3ciUG/lv7WV0ypDJ3vXvfilDk7iKHsxJQ/Y/65bIJkXorAhh0dHk2HZeq0H5B1DYC0conLydsmGV3j6sQpvMtw4MHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbA9ikWOn3+DIOrybZA/FX5cdsLJ2m5Uz2Ut7wquqFo=;
 b=uJRmu4slio9FO2XHzddM012hPzv6oLZ2BwRHPfX2JE0DH6oaZa202YHNXBwAjBwmoNeTBWqDTBBOCFNThw+II9SOCtSWx5x8a5rLSuOaHcJA/9aoAS7wifWb097sTAl4o/Nz1h1kNfENBz40ZtlylcYUZobV7DfcasMKN8/w02A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:50:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:50:30 +0000
Message-ID: <b04e04bc-a0dc-434f-b7cb-7df2cd3abab1@amd.com>
Date: Tue, 21 May 2024 05:50:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Gia <giacomo.gio@gmail.com>
Cc: Christian Heusel <christian@heusel.eu>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@micha.zone" <kernel@micha.zone>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>,
 "S, Sanath" <Sanath.S@amd.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <CAHe5sWY_YJsyiuwf2TsfRTS9AoGoYh4+UxkkZZ0G9z2pXfbnzg@mail.gmail.com>
 <20240521051525.GL1421138@black.fi.intel.com>
 <CAHe5sWY3P7AopLqwaeXSO7n-SFwEZom+MfWpLKGmbuA7L=VdmA@mail.gmail.com>
 <20240521085501.GN1421138@black.fi.intel.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20240521085501.GN1421138@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:805:66::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: a65a8de7-9ef9-472a-7835-08dc7983d4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXZIYVFmazFrN3BGVUlzOEwxTDZEeU5CTDZYNU0ycFJXSUtzVkRZeVNIcytG?=
 =?utf-8?B?YXdNRFhjVzgwNnFYTmV4M3NjbVVYOTEzZnFDSkJMbWhmdHE1anc0T1JHRGJ4?=
 =?utf-8?B?bmpublVMa2R0eGJ1Y1ovZDV5dURNcUJUQSsyVHI0cG82Qlc2Q0pCMFB1Um1x?=
 =?utf-8?B?UG42QzNJTzhXanlNbVJPNExjczhIL2hjRFZmV2FwaGtwQXJDYktsUTdwQzNG?=
 =?utf-8?B?cjIveUJYQ2RNWEFTMHNvVWdyZXdzeGxkTyt4dEJ5SWlxenczZ09oRVl0Ujk3?=
 =?utf-8?B?MHNld0hGUXpCK2g0MVRMbVNHaGY2NzFNVVZEeEN3Wm8zNk5WRFRJUUlRb3hG?=
 =?utf-8?B?SFZpdnBCZHpUQ2xmUjRCdEtyWkxGNStPak9iYnQxdUMwWnZGWDI2aHpwWGEx?=
 =?utf-8?B?eXdVUzM0WkUzMVdPdWZ1ZFVYeXFzVXBQc041czZFclRMNW5KaXdMd2lPQXQ5?=
 =?utf-8?B?TFIzTDBjS2xmN1Z5d1hCdThsWHdmUE5QTW9tamlVaDhQdm9aVEJRQnhNK0ta?=
 =?utf-8?B?ZUJDZzlEV1lGMHJUVkRwT1A4WlpMSVJBYWtQazNoTXVYdVV3NWtrV3hJVk9I?=
 =?utf-8?B?OGFWUy9FS0Yxb2tzcEQ2eWc0S015OUdCaWtOdFphTmpGbHRRK2xBaCs5bXgx?=
 =?utf-8?B?S09maVdkOG1ya3FLVE5FUjFITzV4dHoxTWhma0xnYTk1U2hQMnBYbzFObENS?=
 =?utf-8?B?aWpUTCtHVVBrOWFwWnZZVy9pQWVxd3lDK0JPemNKaGNseHE0MHBVSThuSWZS?=
 =?utf-8?B?QUZRc3lGN1ZDaXZzeEpZVDZjSWc0LzR1ZGhJd1NTYXNUQmZtSmdsUnR3SzlS?=
 =?utf-8?B?Z0NPVDZjZjQ0ajNoN1dxQU12ck9Fdmp1TlpiaDkzclBzWmZXaHcxeTc2cVAy?=
 =?utf-8?B?VjA0YnVudW1jY09lRVE5WjlBSjdFUTF6TE1zaVZ0OWxSNzExYTI2ckhBeklJ?=
 =?utf-8?B?Y2ZRTDdKSGhrSXRkSC83TExhVUxCY3ZPOHFRTGEzbGxCZW5QOHh0S0RLSzJx?=
 =?utf-8?B?a2JWNWFzMTFlYzFXNzhwMFVleEFyZkMzaVNWK2dUcHJsNzFsT1lJSHpjRDhi?=
 =?utf-8?B?a0p3TkhvRTFjWU9KOS81cVFvTzZVRTd3QnlYRXhjb2F0cDVrWG1NWDVzSlFE?=
 =?utf-8?B?NG1MeHdwZncrQ0ZLamtheG0vS1ZuNldwWklmQ2pwVzNubkxyYXRuWFRLMzBo?=
 =?utf-8?B?SEFFY0hJbUdYb2Mvdzd4M0VSUkpsUGJOWjFMbCtIcjBqeFNhNnprQW1kZ2pp?=
 =?utf-8?B?U3NjTEdlMUtlS29reVBRNGdIaUVkeVhWSGkxMWdqUHlSSVJlN0FpUW5adFVy?=
 =?utf-8?B?dGp5OVFKVytaM2xOdExGbWZnWGthY0I3Z2p3VVlkOFlZcjJBTG9BQ3d4b1Ri?=
 =?utf-8?B?N05aR1BhOXM5Q3pqYThHa1BEcFVicTdYajFqWWlyRUFYY2lVb1lpdnRWNWxR?=
 =?utf-8?B?QUhLL0VzdlNCUEsxWHZzNHpheXFEeVlCZktadVBJWWdyRVo3ajBhd2RRL0Zt?=
 =?utf-8?B?bmRrQlJsaVJCcjRWUURzTWEvZnQ3NlRjYXVMaDhHSU93OGo5L2NNcndPN0I4?=
 =?utf-8?B?N1FWb2VSQ1k1akl1TkFHZjlmSkluelExVTZCNEtNVU9vWUZSMXQ2NFU3c2Jp?=
 =?utf-8?Q?9ADxlsLxBEtd79LgbLR7hzO8+qqzreLDtOLFCuUfgAW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWJCVlV3THpTVVlYOVRPWGJtOTJCYWlUYlV0aEJXdERrSmdLbkJRNkJNbGl1?=
 =?utf-8?B?TGUzRkRTUWlhNHlobEJtaDJ2a0IrNWlaY0FXcEVsblRFcTRzZFF4QzZXRU95?=
 =?utf-8?B?TXdEM2V2NlhzaXFoOU1RN20xdGZMQkM1OFNlTkRveko5Z25LeFVDbWNaenY2?=
 =?utf-8?B?MDFMYnlpK3RkVW5mTEo0anAvN1ZuelcwSDZoOVNKZGpQcVhGbDlucEt4akRL?=
 =?utf-8?B?TmdxNnRIUHlLNnk0Z1c4QVlPOFNIY3hlS09KOFZWZ0Rqa0ovZXJXNHdYT1py?=
 =?utf-8?B?UWI3bVNKV1Axc0tZVGVMa00wdkY1R3p6S1c2bTltYVpBQ0VZR1QrdDVhVzVN?=
 =?utf-8?B?V2JMMGJUM1ZyWFltSk9ROUZRWWJycWdiaEJSUC93SEdxUmpQTmt0Yjgra0tD?=
 =?utf-8?B?RDlqSXFyanQ5WkRIY2N3M0c5UTRlTDVXQ3JDODkzRlkwVVMvZnlNNCtqQ3JS?=
 =?utf-8?B?cWF6TTJZSmIwRWVkVVdmcEkrWFp5STY4M3dhQW54RHBwRkwreG85MFZwVXJ4?=
 =?utf-8?B?b2gxMjhQM3Bpa1BUM2dsT2QrZThxNFUwK1djd0V0ekVQdjIzUGlockV1K2Ft?=
 =?utf-8?B?STlrcW81cWxYengrTVJ4dzVpazhnV3lYRDdvckRBcERZNDBUQXRZNDA1RnJ0?=
 =?utf-8?B?azhqQjRXTm1DYzN1c0lDUnNzRTVibmhxZk9QaUxJUnFhdWpYcTVEMlM1eXZ1?=
 =?utf-8?B?YmZLWXBTUDIzc2FxU3dlYndUWjkrbUpqd25MaEUveXZXanZQZnZJby9MMkt2?=
 =?utf-8?B?aFluN0NjQVJORThzZ0xJZ2FweEVEQUhMbmg3WmxTVFVMN1RZbEJrNVRxOTBG?=
 =?utf-8?B?TU02VGJIL1dtNUJ1cEorNnNNWFgvWnlZanVFaTQ0K0E5OElTWjQxbk1MQnpC?=
 =?utf-8?B?YW01VW42NmVnZXlhdnZjcG9wbVVtZ3dGU0c3d2FkTVhTTXJtNjludGJsSDZS?=
 =?utf-8?B?N093NWNOWGYyMjFqZDVHZjRvZTFwUTdjdG1ValNWWldvS0hpTk9McnhWeEYv?=
 =?utf-8?B?b2l6OURPdGdjclF3WXlnK1A3K01uSVNicExiNGduUm4rUHQrVUh0WmNlalI0?=
 =?utf-8?B?UUFmdmdxSTBrL21MOHU3NHF3VWRYMEVtcHJIYk45MTAzMVV2WnhJeHV5cnBw?=
 =?utf-8?B?NWhoT1EyTmRQT0YwcktsalhCa0Z6Wm1oTDllcC9XaEZzTWxtSEFKNjhZWHBQ?=
 =?utf-8?B?ZlBKWDdJVis2VDJuVklYVHp3Y0d4MjcvNnBvUkcydmZyRDNtdjdZT0tSSFF4?=
 =?utf-8?B?REtKWVVjd0F5eE5YUE5HNWRyUnFNQkFaMS9yYyttNjdSYzE4QnVLcFQwcXZC?=
 =?utf-8?B?dWxWenkrMk5HTVVUUWJEVnJoZXRPZGNPbW00Q2IwL1A1TzUyZ2ovWmZtUGpa?=
 =?utf-8?B?S2s2RXVFaFBlbWk4ckhFVGIxb2l6aVZVUXo2TTMybUZpYUkzQjVhNDRGbDRs?=
 =?utf-8?B?U3NmZkJ6dERHMG9QMEdORUM3K0djbDI3V3RYdWxPdVpGSncyZkozR015VmR0?=
 =?utf-8?B?amNMQVNwZHgrTjN5VmhCWG9pcDI0Zy9FeitITG12QVVERVlkZ3pQb1F1eitN?=
 =?utf-8?B?Z2ZHTVdUZ295dzVOWEsxQkJoWDBiZjN4K1lxdjVXVEdFcngxMXhKbkw2MFJs?=
 =?utf-8?B?bnNJb1lWUStkbmFPdWs1N2Y4b3VMNTZ2d2kyVHZsTWk4QUJiczlINHE2S0RI?=
 =?utf-8?B?dTFjQXdSSEtzcTNZYy9CK1Nlb2V1a0cwMHpEVG9WUFRtcHNkdW5rc0RHeEhl?=
 =?utf-8?B?dUhNUWVLMEQ2TmxVMm1YQ3JOSk1kcy9ybHp3ZnZXa0lIYVNFc2ZrNjdWYXRZ?=
 =?utf-8?B?M3JiQnJYdDVNdlhIaDJtY01FYXVtZDNxVFQ5TjlNM01vdGdKZ0F5OE0zMlRj?=
 =?utf-8?B?ektoTU1IYitOTGkxOFBRazFiUjFQNGs3TnVZYXRlQTJvNDV0eHV5VUdaMTBB?=
 =?utf-8?B?WHgzVE0wT25tdW8vRS9sVUxqK1BjdHFiaWdIR3ZjK0ZQd0NLR20rUlVWOG1y?=
 =?utf-8?B?WWdXSFNGRzRZeXFMQTZsVFBEVmJxOXAweVc4bjFHSjRsSzV0aDdzZ2FrTjJW?=
 =?utf-8?B?YVgzQ08wSXZOd21PZTNpczk3cXdVTDc2VWFiU0ZOQkp0bWVHbkNhRld4cUs4?=
 =?utf-8?Q?i5GVOvgQQ7N6JT9JiE9VVKGiL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65a8de7-9ef9-472a-7835-08dc7983d4de
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:50:30.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqtJCnq0m3AhHA2ci9BJTemTfpJjF//5Fzd7kbHSjH8PVM6Ii8kdTpQ0y9yuoEBRTsT8VgfoQ2F1nhbibz7/9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056



On 5/21/2024 3:55 AM, Mika Westerberg wrote:
> Hi,
> 
> On Tue, May 21, 2024 at 10:07:23AM +0200, Gia wrote:
>> Thank you Mika,
>>
>> Here you have the output of sudo journalctl -k without enabling the
>> kernel option "pcie_aspm=off": https://codeshare.io/7JPgpE. Without
>> "pcie_aspm=off", "thunderbolt.host_reset=false" is not needed, my
>> thunderbolt dock does work. I also connected a 4k monitor to the
>> thunderbolt dock thinking it could provide more data.
>>
>> I'm almost sure I used this option when I set up this system because
>> it solved some issues with system suspending, but it happened many
>> months ago.
> 
> Okay. I recommend not to use it. The defaults should always be the best
> option (unless you really know what you are doing or working around some
> issue).

Windows and Linux handle port pm differently at suspend.  I've had a few 
patch series attempts to allow unifying them with some "smaller" pieces 
landing as well as a quirk for one of the root ports.

But the specific issue that was happening was a platform bug that 
occurred due to this.  It's since then been fixed, and I guess you have 
a new BIOS Gia.

Completely agree with Mika the default policy for Linux is generally 
right though.

> 
> The dmesg you shared looks good, there are few oddities but they should
> not matter from functional perspective (unless you are planning to have
> a second monitor connected).
> 
> First is this:
> 
>    May 21 09:59:40 um773arch kernel: thunderbolt 0000:36:00.5: IOMMU DMA protection is disabled
> 
> It should really be enabled but I'm not familiar with AMD hardware to
> tell more so hoping Mario can comment on that.

This is controlled by OEM BIOS policy.
You should try to turn it on if you can as it's a more secure setup.
Some of the Linux stack (for example bolt) will automatically authorize 
PCIe and TBT3 devices when it's deemed secure.

I'm not familiar with the OEM for your machine, but some strings you can 
look for that might point you in that direction to enable it:

1) "Kernel DMA protection"
2) "Security levels"

I know some OEMs also only enable it when you "load optimized defaults".

> 
> The second thing is the USB4 link that seems to be degraded to 2x10G =
> 20G even though you say it is a Thunderbolt cable. I'll comment more on
> that in the other email.

