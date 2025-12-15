Return-Path: <stable+bounces-201008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44BCBD0D5
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30ED8301DB83
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A030CDA0;
	Mon, 15 Dec 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="dF/yqoj4"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67630E83A
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788794; cv=fail; b=FAdochkKvxquL0vsWWcDU15f2mXjYXBM/TBL2u+BbQPcQIbbKF7AhrBwsD/mKkL+Dnx/18pHSgDOwGDkqoKfOgXUGF3svRGv9E5itswhONa7pTP0zvWrOoYMCCiJ4Lsc/48bwCRlU2kaTGP8oAM/bRNNyqudXu/sN3IqZq0LD8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788794; c=relaxed/simple;
	bh=X10OfPPVeSN4jzoUlTB8L9o8WYi7SArTIf08B4ozYm4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KCGDpGq9ycltMreEVKGCgPMufSdrqhYUSuGakpsJfw1VxCX4IjST1+5LX7aExgdqRcn0Kr6dG3KLHw61+KvLghXxmkxr4md6rYSLtkamPvusMUfUHji3pVPi7GvFXtLxCLJINUN2Ei7Dr45fvWiFnBifctfkms3bvkOIClXBpPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=dF/yqoj4; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0uQaXr73LdReGlxaJxeXfv+mzI1DX5uQ/gakgt7vBRMsHp6jk0grJ1RWmwWr8tagYXi7G4eic7yX2HzHM8r10uoaOy/pY4wKSg5/4ze4HUP1hic8xCXcrzmboWFns0LsKTPaw+Zd8vzQGhZoGTRJs6RXnFOfSrZ1oPjsbCiMtyVfJYfVRPfDZKTFKzrzt0DZazWNcjzDAzHbnjn1yj5d4HU4ayfvpjgBlBobKg/zIUYxxS7q2lcAHBjjWurCI37A/tpDG6uGqXptHaVf58q3xTKF5H+91FqpYp2XudcEqi0u0nx01xXOdXUjAE1qiu6EsP0KqgUqmnRCyLKvhvjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNBxHNt2iXoM9s8xIdcjtXfGGPPWeTflX/CFeqRVIfE=;
 b=br5gOoKWxVTQ0SsYWW1T9mw97VM/E72aTHkE+7dBSdQU7QHlbU6kJetOFIqZEh/OzQVa25mFdzvKuVK/s6V7YiHkUJgbtdnBykyKP/VvqIb5O+sRADlRRfeivXdVLV40R/1WGXHlF39rM0phgJz8Li5KrobTwy92rIe10jj7Ro8xnjKmH8/lhe9oqX2OFKVqXqrRzhVfWhNRCWjve4lAi0kvkf7idNcM+vyvgN8J2roIVerqd94JQb2Zu8N8xf27ZOOmH2bkB0wML6jOMuApPOhIxvjkL153H/8MuDJa+nlyszohioD9UIqx5rrewFycVfi6vnokEt/EpWJnhtc2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNBxHNt2iXoM9s8xIdcjtXfGGPPWeTflX/CFeqRVIfE=;
 b=dF/yqoj4SiiCkMjafSIzYqZZIaFnzQCb1Uelw50qMrrSxijPeCLhfHsCMquGH0Q/OU1mb9f3zZdq61M2uB8oQfn/iYhMdPn4ncG5xpq4RlI9wqZYta+zVFar39ByXnmdohVgwcMc3cnazewjxV9OPljXgucv5nr5BUNk2gmd3age7Ev4vJFEeualuuE4+Ie3G0wMhPUTsYLqXX8iwXIJiFCYl6A5X+/g6bkBKLzg8ZEAfMg2Wt+C/u7KBLPKRP0uxuH5C+xiOqjgjWPKu0QbnDUP5sUgAX1/d4rrV7eWZ5n0enQR9y015sOIbBEOZM23j0LskO4WIEdjCv2KcEr9Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AS8P189MB1301.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:28a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:53:07 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 08:53:07 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Mon, 15 Dec 2025 09:52:56 +0100
Subject: [PATCH 6.6.y 1/2] ext4: introduce ITAIL helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251215-cve-2025-22121-v1-1-283f77b33397@est.tech>
References: <20251215-cve-2025-22121-v1-0-283f77b33397@est.tech>
In-Reply-To: <20251215-cve-2025-22121-v1-0-283f77b33397@est.tech>
To: stable@vger.kernel.org
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, 
 James Simmons <uja.ornl@gmail.com>, Ye Bin <yebin10@huawei.com>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765788781; l=2980;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=VT1phRz4deUGA1vIxfcIXkdfXG4XWFqzVot9CAYUYvg=;
 b=wUJnQA0G6DkTc0zlMxZqO1uxLIfaPT02urpZ5XUUr9StUGcZCzG0FE14STQ6NELoI1W+NPUaW
 7p56nbIxFyKCO9P4/sEcjfEz2iSURgpkCN70ul9JFXT30I0eQd7Yrh+
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO4P123CA0411.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::20) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AS8P189MB1301:EE_
X-MS-Office365-Filtering-Correlation-Id: 705437ef-1971-4d4a-5ef0-08de3bb75e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVdrZzZUOW1ZajZiS2tPVzdlaVB2ZUlSQ1ZVM054MmRxR0hLVy9xL1ZJREdC?=
 =?utf-8?B?TTIzRHdzdnRiL25MV1VzREY4aitHajMyY0pkRWxVTTBna2c5dmJIa1ZuUlpt?=
 =?utf-8?B?SGNneGJmNHJ3R3NHajdLZzY0aEhpalNyaHBZYnR2QjBBZXlQZVNiaXpqYk4r?=
 =?utf-8?B?WStMT2loWkt1R3d4Y1VGbXVFcDZiK0xKc0pnMUtKZzN1TkIyRDFPdHVWeFZG?=
 =?utf-8?B?RmsxVDQ3WjY5WTA3YVFlWW9DT1A3em1TNjVHNHg2ZlVOaU45ZlQ1elJPd0g4?=
 =?utf-8?B?Vkpua3pKYmR2Um5PY2NjdGJMNTV3OHZwVURwaCtScVNNRUZ4TC9RQ2xXWmJL?=
 =?utf-8?B?WkRGVXhzSUNpM2NWNWsrRHRoSTlNNzk0K21pbGx5Um5iUVFhT0JZb1FmT2x5?=
 =?utf-8?B?NHV1Y3pRS1l1YjRZemQxZ2dnODBhTFFKYXh5Y25jT1dtVUFPdWZudElEakg5?=
 =?utf-8?B?VWhsOW4zMkd2azV1K0t2WUFkT0RtODEwWVBFZ0gwTmNOTkZpbnFybGNhUXlL?=
 =?utf-8?B?VDdEejZaVDJIelpzbkk3SXhKTjhTeEx1YUY5SzIvY3NINXBsWWczTm5lVjhD?=
 =?utf-8?B?eGQxVmZrYUxZelA4M3FJa1RYdDMrM1BvdXBjYnJQYm9WVU1kaDlKNWVtWnhQ?=
 =?utf-8?B?RkUrd3FrcnVuV3lpbHQwYUlXMEcvRy9kTDVZLy95YUZ6b2RQZFpqNmpMWS94?=
 =?utf-8?B?ODN2WjNtcGltd1FVSGVjQkZvVnF5MnpmYmJvZnlMN1Fnb0hNNVQ1WnFyT1o1?=
 =?utf-8?B?enloWHI0bkx2THZwNXBLVXFJZ2V1c0h6NEJWRWYraGdiTXJoeDBWTFVMWS9I?=
 =?utf-8?B?OU9VNnhoQXZFVkJGZCtGY2ZyL2RxY0pIUFRGUTFwQ0ZYTlZnU2RGbzFqWnZs?=
 =?utf-8?B?S1FFdmZEYUpGdXRXUmxKbFZldnUwL1JnOURuMFh5ckFVYjV5dHJSc25yZ2Yx?=
 =?utf-8?B?d1BVM29qVGhKa1h2R3BHY1dLSWFzT0N1eUNxQ1V4eGNsU05tVlJhb2JsMjJO?=
 =?utf-8?B?dk5VTHdTMVJpYkhJS1BWUjNzQ3JnMXdONUVMUXFlTlNNVkQ4Y21qa2ZySHg3?=
 =?utf-8?B?MCtleTVFV2tkL0hNMTlMN0QzcXNQQ1VtZmp3MysyNmprOUs4NUxVb0E2V2hZ?=
 =?utf-8?B?UDB4SGJwUjcyQ2YwbTVBby91Nm9nMmZ5akM4T01ockFTZnRZYlNuMDJQNW1T?=
 =?utf-8?B?emdpSFdpejRiYzNHQWR4ZFhVMTJzeWhsSmVDQ0taQU9sWlBXSGZYbkNkTS9Z?=
 =?utf-8?B?dFY3Qk1yY29HRnZZQ1gvN2J5NlhqR0k4NTRRNmFXdWliTXhjTnUyMy9BTkEr?=
 =?utf-8?B?TFc3LytTK09EREdYMlhQV3Q5Y3ZSVmNQQ3lYMmFicTRVRDlkTDJNMDNKeW5S?=
 =?utf-8?B?dHBueGRWOEt4Z0EwUkRSRThiRHhCVXVpWitvYWp1ajZnc0tidDF5TlF6QmFT?=
 =?utf-8?B?UDhDSnV5WXZyOHJKMkFiMmNVbkNKK3R6TkliRCthR1NBQTM2Y3JldjFacitR?=
 =?utf-8?B?NFRJajBudTdqT0tBNGFrY1NURFg1bk5SeWdUODduc1luZEpKcEJNNXdZVmI2?=
 =?utf-8?B?VGZxczNCUjk4VEFQMzFKZ21KVVAwalArUWxnYTh6TUZaZmlyeW1aZFlQRjVv?=
 =?utf-8?B?dmh5eVNGd1BITC9JMGtZS2pBempsZ0ZWVmRiOC9odlR1b01nSlN6eXk4L3Bi?=
 =?utf-8?B?YjJDQVRaQUVSWWorMGtlUnhyTnpnRll0aWFmYUoydVNhdGJwajlqUUhQZm56?=
 =?utf-8?B?VUxwbTQrSFB6V3BhY3lIcnNEK05QQlVXaE5CUVJYTUxiVndzVUhHZlBzbkhF?=
 =?utf-8?B?MzZRS2ZWMGNBazlMQUplNXJoVXk2NGlwNElIQk5GdEdheFdwVFRHdWlRMlkr?=
 =?utf-8?B?UzhUUWJzWDQ3YW9tOGU3c01sT0RLWG1FN2I3NTUrd0xZNnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTBxNjRsK1ZGUDFvdU5IaExVNG0xUmZySUdWRTBNUFd6MlNJUHNHT3IrTHpU?=
 =?utf-8?B?VW9iTlJ0N0hIU25RemFibVJKcWgzSWo0aTduenFETG5FSmVnZDRIRWhXNTdR?=
 =?utf-8?B?UG9lN3ZOMG1xQ1NRTkRQM25RMS9oVDY0ZkIzZlB4Yml0cUo5SDFYcUk4ME9Z?=
 =?utf-8?B?d3dGTEZxWUI5S0FZVGlOQ2hNcTI2S1dPTEdaUmFsMElET0RvV0pZUk02MVRL?=
 =?utf-8?B?MkdscUkyaHhZWlFPVDYvYWxoUnJUNjQ4Zi90d0U1MGZuT0pXVmREV245elBr?=
 =?utf-8?B?dXZnVTJGTXZMcms2TVpHc3FndU9LSm8rWkZ4eW01aHJ3VGFZdGtHdHRKa1NU?=
 =?utf-8?B?bVMrVVFPcXBLYTMyaXFzYXRuQlBXVnJ1b1lqVklJOVYwaVVXSmhIdGVOdm5H?=
 =?utf-8?B?SUYrQUwwbE5XUnRWQnBlQlRISExZVVB1ZlovOFA1bms3NGRkYXpUdXRJU1B3?=
 =?utf-8?B?SmgvcWdmRVgxZG1uQmZabGZSS2RzbFlQa04xd1dEWE01d0xUYUhNWkpoRXcz?=
 =?utf-8?B?NnN1NGJuNHBGcDdFdjZkQ2dkamZtNjI4NW1MUlpLeDhRMEpWS25ONERISnVu?=
 =?utf-8?B?dHRsZG1LdmF5QnJtSnZOZGxiSkh3M0dTUkw0NXFRSXpFTnBJeitHa29JRlN2?=
 =?utf-8?B?ZVF1Ni8xRno1Tk5waGVHWmlqdGZWRjJJK3VUaWdYZlh4RU9oS2tGWHd4RGtK?=
 =?utf-8?B?MGlET2U4K0tPL2NaMGtETk14RmZqUmk0SjBGN0MrNjJuN0pua1lYN3o1M3lx?=
 =?utf-8?B?b0lWN20xUVdRZUlGVTVMNnhIV2ttcVQ5UVhxaVFvd3pCekRWVzdBbU50R1RK?=
 =?utf-8?B?TXd5dTdVR3g3RGxKbm1RTURWSWdXbms0cmh2bG5NKzJFZlZJLzJqdzE0SGdH?=
 =?utf-8?B?OXdyVHdxdjdvNVZsbXBiUDZSNllXK0lMRVdBS3cxekZoRERpQUxNb2ZLbnBa?=
 =?utf-8?B?eVNYQnNVeHp5a3VKTzZuOE9McldTeVRPL1oycUpERmM3WXYvTER5cUlxM2NP?=
 =?utf-8?B?dUIwL25RRDk5bERXS2swMWQra2Jya0x6eldUYmdVcnN0WjZyd1BVcC9jVEp4?=
 =?utf-8?B?ZUk0OUtuMW1tMncwMmlhUmZ3dHVDRFROd0V2bDlsMVFhWTlXUGhzMVNnVnA4?=
 =?utf-8?B?dmFTcDZyZ2ZnOHFqOXBORE1Sa2x3V25rN3ZTbloramtaeEhFOWdjMEI1RzJo?=
 =?utf-8?B?c3ZLY0ZnOTkvYlpBOTJNMXNvcm8yc21jdDFpUHVkZHdOQTFQMG5qeWh5UWV4?=
 =?utf-8?B?V0FlOHBzN2J1cXZVUGVISE4zRGJUdzFENzBqQy9FWnhoUDZlU3R2QjRPZ2NW?=
 =?utf-8?B?M1hjZUxXeTk2Tm4wdVRpU2VOLzdrL0VyVGhhQXg2MW43aEhIS0hOMk00Q0lx?=
 =?utf-8?B?aW1yQVJmanpUd1B4MGpCbDhibHR6aGQxLy9QMWE0OHFjdWlnbHc0WTY4MnJu?=
 =?utf-8?B?RGRYN3BjTnZweGlyUDFKT3daR0ZpWHBuVHdXdEZOTWZPVlpxakt6WWdnclFO?=
 =?utf-8?B?dXkwb0tEQWRudXQzcEQvVDBSanljbzgyNnM5alNrcFBiMWJjcHN4MlFPUVRI?=
 =?utf-8?B?MVFobFhYeTI2R2RyeWwzYW14cC9iWjcrdGJlazFNeWFBWU5aRXlnT3JlZW00?=
 =?utf-8?B?ZTA5SEdHektrYzRuNi9vTUhzWnlXL0tzcGluTHhGMjJHWVNTOXRnY25UOW5D?=
 =?utf-8?B?WWF0dWQwRGx5azJxN29YUnYrZ2Q0aURQWm1JaWRBcUVVNHAwQ0R4Q2wxeWlW?=
 =?utf-8?B?MXhyNU1qZWg0WmVLNWNvamozTU5WUGU5emZKdFVhUXE3Q0JIamhFT21Jb0xa?=
 =?utf-8?B?SkNMVVdxNlFiV0wyRjh1dXFJaUJFaVFKK1JzK0lZdnE2WjFoUUwzTnlEdXM0?=
 =?utf-8?B?NHRoZm5oV0xuRFZMNkx6a1YzajBGV0dlcHJjTm5hWW54WmRpcnc5U2gxMTZZ?=
 =?utf-8?B?bDRmTGVWQ0N2WWkyTTR0dXZjZmVvM0o4dmhtTWg3OEd3ZDNlRkoyMU9TVEdB?=
 =?utf-8?B?S3NNTWw3Vm8zK1dCSTFUeDRIZVhQcUtuZ1p2c3ZMMitEYzZLUHE4OHR3QVdu?=
 =?utf-8?B?VXNNSUNmZ09nOGlWYWZvQWYwWUtBajNXaitkeVh3dlI5K3JjZHU4VE1BTW16?=
 =?utf-8?B?djFUQmw3N2gvT0NhUVU1dWJueG10UnVVZTRDNkdJRDJkUWJxTUFhRTA0a0g3?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 705437ef-1971-4d4a-5ef0-08de3bb75e0e
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:53:07.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgkRYVGNM/nWWPTHMYEJD3gk2xIxT4weJpXo0Q3zJuoMpqjm5k79n0Y4JGIc0aVjRhd18y3qvRZWuhBq8vNRrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1301

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 69f3a3039b0d0003de008659cafd5a1eaaa0a7a4 ]

Introduce ITAIL helper to get the bound of xattr in inode.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-2-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/ext4/xattr.c | 10 +++++-----
 fs/ext4/xattr.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 307081c99437..cce549ef16e0 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -653,7 +653,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -797,7 +797,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -883,7 +883,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+		end = ITAIL(inode, raw_inode);
 		ret = xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
@@ -2244,7 +2244,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
 	is->s.here = is->s.first;
-	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		error = xattr_check_inode(inode, header, is->s.end);
 		if (error)
@@ -2795,7 +2795,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 */
 
 	base = IFIRST(header);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 824faf0b15a8..e7417fb0eb76 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -68,6 +68,9 @@ struct ext4_xattr_entry {
 		((void *)raw_inode + \
 		EXT4_GOOD_OLD_INODE_SIZE + \
 		EXT4_I(inode)->i_extra_isize))
+#define ITAIL(inode, raw_inode) \
+	((void *)(raw_inode) + \
+	 EXT4_SB((inode)->i_sb)->s_inode_size)
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
 /*

-- 
2.48.1


