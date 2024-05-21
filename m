Return-Path: <stable+bounces-45496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2618CACB3
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E061B1F2203D
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226B745E7;
	Tue, 21 May 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JbUPiJE4"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA171B3D;
	Tue, 21 May 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288782; cv=fail; b=Zg0KDpz77UtzWZc3UZHOyuuYlhG7xQVEA9aVb5pCZiARJvj2iMY3dAqTOFi/kYW/3EKx/k1PXx2+Gxu1EaEIWNlMxL0DTm64gMFef3BFPEP02Aye7ZdG32Qb8xe1K45NOlCUNGWadq8E8NkbN/D04Auh58K3ffT5tqchHzncgV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288782; c=relaxed/simple;
	bh=UzTqVBYVp3MOPIUVQ1vG7ev8W1GEm0G/BgkUl0SjafI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NfjyBcNW9usVejfOGRe1OhmsP1SVrPu9/KTGhZJQDKwDwM44iyp7oBG4fyRnYM91t2rMkYU69d58WNcO2RzASzBhA/qsiQgNnmE2cq+E4pdv+81Fe/UAXW13uvb7ymCRzxynOiMjSU9N5/qhlXLznyNrZMZ986xsbE2oRWdJbTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JbUPiJE4; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeQ+tBcd/tAKefreGbWvpC+g0wYIQazD9O51k/PpT52JXcDqhomJxuXXqUfhhA1qZ4QZiurpJJDaJTCDCL5yCSg1lt27pew/DKdAzvICyFLo3rfqR2RBRHEOJzjKZ+DNnM+TwISJbgR2JEIzveZZFSVptudjKutyS8Bfv6KZNgYcFohwEhE2RuXN8Va2OGIh/mTCXK4k/zgCu31dFcHh8/Yc3hWHK6Mq+OfshFrP7//n332zOOV1Cu8l81YkmfEBocuHCP/R0k4Oq8zNbc3FMbpvDcNSWX+arsM4EAwYigORGI7skR6MAmHheIUGFmdeGrT+3it3hOjko7Bs5R5ucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFEaX1++H7A8n07KEGq7VOJSpbf9+5fc77/Cl8xXUvY=;
 b=WvOnoE+1VI5wH9xrQ8rDtJ2DCnCePXTqiL000r2Vk5NpHMwnvd59SSkXdlwZWYGssQwpogM1Z8aVwtdn+rUr+Mle2MC07vLpg22vA9+V9sUT6lEc6arFYa5zl+hWlM/3TKT6j8UQWtVif+EUz5GNkdWgWoayHP6ZZ/hnTGHuxDiYnwP2WosGch3S2kBfS43hoA7D7GfF9Fmo14o4VDRarnMpBAc/mB8P0jji+Gg/GNbY48rYJrK7nbs+M8mvk04y0Uc5zLQnmR63yeTrxO/9lBNbDyZkiNhFSIjAUUSaMUJzPfzvM0v4wbw1C4Rs02jIGqilt/VoJiOn06FdKauhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFEaX1++H7A8n07KEGq7VOJSpbf9+5fc77/Cl8xXUvY=;
 b=JbUPiJE46dqDKvZLJ+lIayuRgYKEfqaMnrlKtLjEtyDISQ4ucAQPJPmRMAOqcMOFwO1idm+/3o8x+j8jIvGSYeQC3JT/9TnEZrMLc8Fv6oFb/IFRu7mwNKWRFSe7CWWexf/SSQTPS2JZO6ebJyyseoUjq0sJt4w3x+wOYF8uTnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:52:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:52:57 +0000
Message-ID: <e7227b7c-d544-42a2-8396-a7d104b54e31@amd.com>
Date: Tue, 21 May 2024 05:52:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>
Cc: Christian Heusel <christian@heusel.eu>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Gia <giacomo.gio@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@micha.zone" <kernel@micha.zone>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "S, Sanath" <Sanath.S@amd.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <61-664b6880-3-6826fc80@79948770>
 <20240520162100.GI1421138@black.fi.intel.com>
 <5d-664b8000-d-70f82e80@161590144>
 <20240521045940.GJ1421138@black.fi.intel.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20240521045940.GJ1421138@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcd3ea4-62ed-4925-7cbc-08dc79842cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUJxQzVEYjRnVzQxeVBiN0h4SnlXNHlPekdsT2Zza3ZlM3lJZ091K0pTQ2Z5?=
 =?utf-8?B?NVdxc05ScENIQ0Z5MC9FbkZadUJYdjhtb3hNcXhMcThQT3NKd05OZGpMNDVQ?=
 =?utf-8?B?elRxeHA3YVdTazlXM2o5STk0MElOZmROdE1xQUdFZGlldXNyZ0xmNDdkNkk2?=
 =?utf-8?B?OXU1MFdGY2JINkpLSlFEUnErdStESGQrSjVZZll5aFMxNUdKcnhOQ2RRa2Zh?=
 =?utf-8?B?R2R1dWRsVENaLzJ2Q1IwdzBwZWJ0K3FPUnlOZU1yUktvUGZOb0xVenpMaXZz?=
 =?utf-8?B?clk3RDlLOGl1Tm40dDlnUldzRmdXckpHdHpjY0dldXcvcXRLQks0bHZ6TEty?=
 =?utf-8?B?bS95SWFjdFg4c1JaQXQwNUVOL1ZRVlFVTnhIck1RK3JrRi9GejZacGt4eXQ1?=
 =?utf-8?B?S2IwcFhJUE9OSktjbmdIRFBwbGY2UmRabXJDK0hYSkpGZHpmZ2MvWHhzL090?=
 =?utf-8?B?NTZtZVQ3VExPdWlFRTJZaUdaVmdKTHBoeERnWEVhbGsxK3JQV0JxeC82cHgy?=
 =?utf-8?B?bEpERXJZUXhHMXl2ZjFIRWxWQ1lGdWtld3dMV3BTd296eUpzTEZLVGZodkxx?=
 =?utf-8?B?Q01CeHZpWWZzYUx3bEFKQUNHeldzTWZxKy9sdnIwTkpXYml5N3pNNHVQYURs?=
 =?utf-8?B?V1dsdWtyUXptTHg5NHlSTWo5V3NXek5aU1BIWmVXcVdSc0xsdUppRkNodFRE?=
 =?utf-8?B?QzJWRlJDVWlSSDhwUTVqVEpKUDFSdkVWRWJETndnUmdrOU42NkhCNHNwQ3Ji?=
 =?utf-8?B?aFVZbnljVzZlamdFSnFXOVFkd3VJM2ZNM3YxajduWS9ycXgwRDk1UkpxQmdQ?=
 =?utf-8?B?SkhSVHMyL2lrUXRaZFpCZE9TcmhvbnhUbGhDSnlmMW00bEMxK1dDY3ovQkhy?=
 =?utf-8?B?aSt0WklPOUVRRFNTK1BBb2hYb3FXWnFWRGpRdXJ4YXltd3B3R1VFUjdVVmRV?=
 =?utf-8?B?R1N0K0lmQU1qTW9LWlNSSFg0OTArVjlxT0kwWHdoTUM5TEo4c3d6dWRFZFZx?=
 =?utf-8?B?Y0Jna1VMMWhnVHlHSGozK1NJM2Z6ZHpHdWZuaHMvaE00enNpRVVzMXBXcUJQ?=
 =?utf-8?B?cWZxQ1h4Q1pDL0t1ditKWGlzWm1iYmZQaUFWTTg3L1dNdk5zNi9iY0kyaDVt?=
 =?utf-8?B?Z0kwcnUzZVB0ejdDMEpPTCs3d0FyR0RpaHNnd1M3clQxT0NSd3VvWXN0SnZq?=
 =?utf-8?B?bldkc1NvYm1VZVhHZExwN2lpOEVTd1IxbkJUbVc3QjhrSU1XYnluMFRGK1pT?=
 =?utf-8?B?eW5OVjRBNHoyYWdJUEVaNVJlbVplN1p2UUVKRkQ2Mm1ZL1UwVk56WW1aYTJE?=
 =?utf-8?B?OW9BVDB3K3p4NXBmalJ6VnV6eUtpaTJiVmpVVWpoZS9ESkFiUkFSSGoySy8v?=
 =?utf-8?B?UVc2THVyNDVQMVpHYmxsMXp1aytvemNuZDVPTFVucDlWUDRNUHRRL2NhRU1E?=
 =?utf-8?B?RXJ3eVNpQXNKc0FINzFDdXplT1dScjFTcEtkMkZIbDZFZTNRa3JIcGRRNjNX?=
 =?utf-8?B?TW5IZ1JXVnBhNXE5SEkvT3UwT2FocklENkNWeWxCZ3J5U2tlcERzNFZmK2VI?=
 =?utf-8?B?OGJxRHpsSUhjeThPWnduUXhtbkFwZnd3VFI0WGJXOCtjdkZNRlJ0WE1LZEw4?=
 =?utf-8?B?clZCU0N3cE9TWi9zOGtSV2l4cXVxM3RVcEE4RXByV202SDJHMmVJNzUzdUJw?=
 =?utf-8?B?cyt0anpJb2d3aTIvVWhGZ2RsLzc3cmdhT09TZWluL0tOTTBEU3l4bEtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mnpnai8zUzFQeERka0UzODFQMzAvdU9UREJQUGhoYzk4Q3BVS3kxcElObzV6?=
 =?utf-8?B?WHA5WlpHZE1WK0tpa1J5eXBleVl0VVIxdEtyUDNLRWVqb0FScjdWaWVja0h3?=
 =?utf-8?B?VjlLcVBVL01KRjhjanlhT2E3YVM3Qjc5YUdaTHROWVA0MXRXeG9rNnFNL3E1?=
 =?utf-8?B?aW5ya3JKQkpHRGRlL2JtajhNYXNLMEFhbWNaaGRaendSTDhFU3dpaGM4MTRJ?=
 =?utf-8?B?OE9vZ1k0TmlIVUdsQ0RjWnhDMzFneThKYTRubUhhVnNBNlRndkdoUWxJNnk2?=
 =?utf-8?B?Um5lUjh4NUh2OHFXREFFa05YNThCTDdJcVFna242SE1jWlRWUVVya291RXBW?=
 =?utf-8?B?MHFKZXlDMkI2eUVWd2VKeVBVcjgwbzkwdm55WUQ4VzgvMS9NNTlFT28wVURh?=
 =?utf-8?B?THhCYWYrdFMwQm1KUGFJbys3S0hZU3ovU0VaNkZicFZKM1ovOUlqai9RbFNk?=
 =?utf-8?B?bnlWa1N3eDA4QzM5cFRMTTRFYTB0Q0tnYVZCeHhoTVlQcUszQmdIVC9QRjY4?=
 =?utf-8?B?ZDZKS0hqdUxLK0lodkwrclZRS0t2OXJnNEtXMWlnV2J5bzNBNVlBNy9FNlhW?=
 =?utf-8?B?S1VVditiSkpmWkZ6UHJKSkFKQlVOZ2VGL0pNNUhQZzNnQmFhejNZME9Ybktn?=
 =?utf-8?B?U0wvZ08xV2dMV2Zkb1ZjVnNqMU9vclU5TlhzK3dCaEtvaVdLajZ5SGg5ZW43?=
 =?utf-8?B?b2lBeG9hYjh1cUFSRzFGUG9hYkRvY2oxWHlpdmd0dGVmUnZvZnRRREgyN1Z1?=
 =?utf-8?B?cUNWM2p6SDVYemo0Vmd2Z2NoVUN4MWd1bjlMa2ZpZzRGRDByQkJDcHVRMTBx?=
 =?utf-8?B?V1lHeEhpRzN5N3crdC93WkhrdWYxelg2YWFCU3JycTMwb2dNc2FZd0pDcXNk?=
 =?utf-8?B?NWNxckgyTW8vclBwdXkrN09IclY4SXczU2MyWnhBQ0grdm5oQjF1eldjSzIx?=
 =?utf-8?B?aWxkNHZBemZ4NXdjSTc2cTBnaTZXRnY3Y3FGQncwWG9JU2I2MnFXRnAyTEp5?=
 =?utf-8?B?aFpGUkF0YnRwWFB0VG9VUGg3UXp1TlVYVm5KNCsvRjhHTEhXdHlaNUtFY0Ft?=
 =?utf-8?B?QjV0MmxWZ3VidnBqUXRvdDd5YmR0cmhpVDJaWm5BbG1kbHp0VmVudHNWUXVK?=
 =?utf-8?B?WE5XNFBIaGVBWnZQZlcwbGt2V1RXUjl2dkNyL3pHSUNVcUpyMDk0NUhiYXlV?=
 =?utf-8?B?YkhaenM3YzdSUnExSXBBRWs4eWVpT1ZwdWF6NWlOcEFzZ0dsWURDWHBKUTVl?=
 =?utf-8?B?VGtrRGJQNFlacTBjZUszdUpxR2krak56aFlTWkJVZ250bTYwZ2tGa0Z5a2du?=
 =?utf-8?B?ZExoYndHQ2VGUENWalFtRGNjTWZSa1dhc1hCZXQvWmRiLzRwcFdQdU5NclB3?=
 =?utf-8?B?OFJIcVFLVHpFY08rbllwNHRka0VyM2pSVGJCS2d1TEpFUWhROXAySThCVFRj?=
 =?utf-8?B?YnU0QmFidkJ1QmhiQnZOQzNzdkFXbXNzL2NnaGlxdTdndUZOZ0MycXB4eE1Q?=
 =?utf-8?B?YVAvbVE1Q216WDU1RlVSM3drclBiYzVlbXFqRjUrc0lCZWVnOFhOR245VUZ2?=
 =?utf-8?B?aFgyTVZHWDJnQUpUaFJSWnQ0THlKbWcxc1htZHRTNTA0R21KaUFKZUNLQ1d3?=
 =?utf-8?B?OUoyK2pkeXlsMUFTaWZZTEh2VnVyYWNxSDZ6NHAyUFVleGVuazVYZzZ5VkJW?=
 =?utf-8?B?Zm43UW5yaERIUGpzZzJYbDBDeUJlYndZTnBuUFpidzhCTk5ZK040R2RhSU9S?=
 =?utf-8?B?Z3RobG4xWURPK0ZnbW0xaUZHQnVEOHVwUXVhOUY3SmJxS2g2cmI3TWhpQXRR?=
 =?utf-8?B?eEYyWXljZlJmRk5sNU9sYW5iYVNaL0VBYVVMK0Q0VFlzRXVUdHIyT3dPcXIy?=
 =?utf-8?B?YmVIZkxVU0lLa2FXYU5mbGxMREVaUFU1czNzZmJ5elg3dXM3NlRsaGJlS2p6?=
 =?utf-8?B?dE16V0NKNGM2ek9wM2wyRnNUYTFjZkc5R2NZS21lWDBEeFExL3NudTV0NG9Q?=
 =?utf-8?B?MEtIalBlNG1ZWWtJekxBVmhXK1ppYStGR0UxOEkveW96eUx3VEtUOVlUWHRV?=
 =?utf-8?B?QVgvVkphYit4MUdRcTRTOSsrUWNoYklPanFkMFgycEtOL0RtK0Q4cnoycC83?=
 =?utf-8?Q?hsQxgpq64KwNNz9NBc0bkrcSh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcd3ea4-62ed-4925-7cbc-08dc79842cd4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:52:57.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+yjZ7EQLHnvUUq7dgfxw4KGxUji0o/xLOgf+2+vC1jAmnswsHTfh/rHN2BMiT0a1F1yH4J5RNXWh4Ce0MP79Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056


>> I still don't understand why this happened as it was working great for
>> years and is still working with kernels 6.8.7 or older. But
>> nevertheless sorry if I wasted time of anyone because of broken
>> hardware.
> 
> I think the BIOS CM creates the "first" tunnel using reduced
> capabilities already so this makes the "second" tunnel fit there in the
> 18G link. Now that we do the reset the "first" tunnel is re-created with
> max capabilities and that makes the "second" not to fit there anymore.
> 
> But now you get the full 40G link :)

Well that's awesome!  That confirms there were other issues besides the 
one Sanath found that get fixed by not reusing BIOS tunnels.

