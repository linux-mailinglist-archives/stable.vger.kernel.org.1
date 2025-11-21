Return-Path: <stable+bounces-195477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C02CC77D62
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BA724EB6BC
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6A3358B7;
	Fri, 21 Nov 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hgscvUQ0"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962233A00F;
	Fri, 21 Nov 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712852; cv=fail; b=n4uWYTDVPTr6w1UONfmQCb1X9QSua3uy45Imgmf7E8R0oTz5QMf277BYrNzMFvKRXHLDQl6xFDYzvfPGF9vax0t44Jmp/ZqefV7Zg/9CXgZ6ootkfM/ruXQMgTdI5DyBLFKFIx+nf33gk5QQKKlj75UTxZMsYzNnw3JKvlo1hMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712852; c=relaxed/simple;
	bh=q7SxXMECa6WLFiqRRO2N82woUHuYk1Vliy1DXwlsq/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p3/HtfJazKBN3+4SKx8okvcwACyONCDjhGITxZI/MTIUCzthSwBw2hGS0fgqQJmcWKCisw19ByeyQ4cdgg5Hr/BAngrx7b5WOeUy19PKF8/wWVbTITF8E1PhHxULpOeFBg5ksj04fJUTLd6f/sHphOicoFwzlgA/wXHYcPGeqXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hgscvUQ0; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzzMbIwNq8QV3W+vXlIYqmSkWBZh5h7kv8aFVUVvJgBN8NJS5d5eXi4NrCD6ieDPvo64QLOh+WLAiPHrEs7rAVjFGWeR3KZqOCbspuMDQvyDcP1dngRKBodnwosvHJRWCYcOSnFe2ZPM79gpj9UY5jUO3kGF6GWw4AzIllrszuqkomdT+8qGcCWN4GNo4M5lMLoo991TTUh03XcO5NnUmK994xHSUHKy43EhzxYMG+uAhW1oZm5VWefGrTzwtb7pLIa2dUtdfqvTkgZoZo+q8U7BPFju3CMmQ6MRhivj8/nbs4sApgeW1ydISxXBACT7Poa/aRE/k0q8BxUO8G5qXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyzAz2i04XSWJbOyxzke2238BVwMkYnVZHY6cgRVu0c=;
 b=q4gjlLhrkkBbIgHT8P3cOMHMsTozuRtEuwbI5aKbr8M6vUAoYFoBnEkesG89OmgsN89uFggU83OzTU9lYlT/8MaVnrY9KqrbbqRK0SaS4M+4BKtTA+tQrJr/iRIlW+4OrMNjAfhrvev6SLMT3UB1B1QNCH63eDFexMeNrVjGCus7g/UDHOU1LfjQIyx3KdGaZWp23yeKrWRSIC+hSAY+3mtBrSBBi+tTdkCrAILB7HJr2pFNrXUc1LIsoNz2ac94xhlvXF22UPd7LzSepa8v6TDCc4NK+T81QM/t27Y/Mq00Gr/KSzHQM47tRx93fE2F0ZZBqPESgGQmJZZsVmijew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyzAz2i04XSWJbOyxzke2238BVwMkYnVZHY6cgRVu0c=;
 b=hgscvUQ0DDbDe5eOeSX7PHlE7Slpg7iLRU/AvN/G7fC8SouVqb+MMMW5vWwxYTyBzp8n78t1egXtZ13jkQJk3QOdC8d5C3WfijbvbDGBVkeTydyXEJpv95f4qPkJ5Lk+8E0nqlbm1IMeP5pHoPxUINo7J6vhqbWMK4I5+nfhwXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.12; Fri, 21 Nov 2025 08:14:08 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 08:14:08 +0000
Message-ID: <653f362e-a32a-416e-89c6-d8c51abf2cce@amd.com>
Date: Fri, 21 Nov 2025 13:44:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Relay __modify_irte_ga() error in
 modify_irte_ga()
To: Jinhui Guo <guojinhui.liam@bytedance.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, Ankit.Soni@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251121052139.550-1-guojinhui.liam@bytedance.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251121052139.550-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f9c869-fb6e-4899-eb00-08de28d5f1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejEvN2RXK0ZHQS9HaUlYbzJadVB6Vjg5Y2prckFoSVV3UFhuUkVQY1hnK25P?=
 =?utf-8?B?RWlUTENqQU8veE9TQkdGS0o2M1ltUFdqMTN3NUIxSUtHYWtmS1cwTkNPU3Jh?=
 =?utf-8?B?THVDNlRBck9sRENjOFd5N3ExZ2xia1JMUm5jeG4wRUdLVlFPalZRZkZDSzBK?=
 =?utf-8?B?ZURiOFRWc3JIS014N1R4ekhzUU8veXg5aERFUmZTRHFDWnhMYzdVcmtCdFBI?=
 =?utf-8?B?WXEzWEJJOVhkQ2NKTEtZVTUrdUh5Z0Y3V21HazFSLzJXYWd1R0NKSE94Si9M?=
 =?utf-8?B?TEJuWUtCV09QZ2pvTXRXMDZlWmx5bGJtMkVvV25nWmRtL1FUL1Yyc1VOcnFu?=
 =?utf-8?B?S2dpTkVQNE1CS0ZqTzZxdUhITmZkcXcvaDdKU29TR0tESXZiWXVabGF0aW9h?=
 =?utf-8?B?dU9SSTFrdStsTkNRci93L3V5ZnR0cFNOSy9vV2krMkdsMUpJUFF4M2liZTV3?=
 =?utf-8?B?eGNYanFlLzczRWsxUHZWcUtTbzZ0akR1blY2RlR5MUR0UllDVEwxQU8zem04?=
 =?utf-8?B?c2xnQUNHdE4rOHFUSUJ3UjQ5aUFjSy9Oc2cweTZlY1ZEcEhVVGF1dmpGeS9t?=
 =?utf-8?B?OFA4WFpZZjFnaHVJK0ZrZGw1WnV4QnNHblZwemJuekp6d0xjTWpJeW42OHly?=
 =?utf-8?B?U0kyZXR5Tzd6LzN6eFJBSjloYWwvRlhhRmtnaVZGbmtHcVlMVW9SWW5CUCtm?=
 =?utf-8?B?Mk5pTHh4ckF0WG1RNVFpc3F3L2R1Z2dVWVRQZkRxbmdLd3VtcFNWZDNRU0lY?=
 =?utf-8?B?WGpJNWwzbVppMHhoZTBhVElDT0xzS200cHA3Y1gwSFNiZTVnNnBXSS9rYmpk?=
 =?utf-8?B?RE0zNGNrK1lvaGI4ZDc5MXgxclM3cEpFM01PbGFwSXkvU09oNDRpVzZSb2M1?=
 =?utf-8?B?R2tyQTREV2xlTDE0NHlLcmd5NlNZcVVUKzVHcTlhNjNXcENxWEhHOC9HUEhx?=
 =?utf-8?B?akFETExHMkVQRkFzQVFxeDBjSVViczgwaE1HWThZY2YvemNUWVdmRWxsbGRW?=
 =?utf-8?B?d2x1bW1qQUlOQ3F0SE9KRENKbnprbndQblFlRjRnZjRiMjhja2M1a1IzM3Fn?=
 =?utf-8?B?Nkd1QnZUSWNXVXEySy9qNG8wbHpTYjlDbUZ6WmtCTjdyNjBxaWh0ZGxYbFp5?=
 =?utf-8?B?TFRCVEthVEVhSUhydVY0dDFqM2VHQVZ2VlNtNlVjdjBYb0FvcExjdUZqUGhH?=
 =?utf-8?B?aVF5c1NNNDh0My9SRVRKRitOcFYwS0FDb25uN2txSXd4MUtnR0lKNlJ4WUdo?=
 =?utf-8?B?N250WUw1WUdEaUJyZlpKMTExanUxMkNKd0djb1doUlRlWFVXbDVueFJ5M3Bk?=
 =?utf-8?B?M3pUbHlMaHlURGJKUlgyNThTZFdLdVg5Q09Yc09VOWIyRCtINW9FSXVSaGd1?=
 =?utf-8?B?WnRsTW45U3pKWTFsSmhoQTlsYzgxVmdCV1VXOTdRZ3l0Z0NKYlR6aWZYamFP?=
 =?utf-8?B?UGh4KzB1WS9XeDJKSXZnRkJ2Rkl5d1VZN3cxUlhyZTZLdmU0ckVOTCsxaXZB?=
 =?utf-8?B?VU9ZZ0FvTFZBK0h5a2hXWHQvMmNZbHkxY01pUS9ramFCNHplYk9BYTlzUjBU?=
 =?utf-8?B?c2dVUjlaVEgzbWRTOUY2UHFsWTNhVlVoWEJSaVFKdTc0dWozQTBpNzJiSjZI?=
 =?utf-8?B?alQyMTc4ajJVVEJ3UFcyVkZrVEpKZHI3MUVCbG9BOXVpakh5ZkNtTnBxbUhZ?=
 =?utf-8?B?OEhXeGJNS1lOV3B1VzhhYzd6REdrV2hWWjl1TGtPNk4wdXI4aE5ETFFuS2Ri?=
 =?utf-8?B?bWR6M09BRmdqN1IvY3NscGlYTUlSaXZwakVOMlFBZmM3cklQOGZUVHlQczNE?=
 =?utf-8?B?dUs0SFpMYnpNOGhaTStLVDY1dzNVaG1NeGZYREdvZ2gzUjN0TStaK1RQdkhM?=
 =?utf-8?B?VHFmV3k4emlmckEwWWFzWWdFTTMrbGw0SEVPREFwcnBuMGlTK1BLN1dnTnps?=
 =?utf-8?Q?kGa3musgjRb4eUrrUw+azWRuw1XsvN6j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnFIUHg4V2diVXdNSWNtZG05Y0h6NGNtcWJDL0FKNEFZbzFINm83Mjhtemp6?=
 =?utf-8?B?SmVlcUVxWU5jUklxQ01jYmJrdmZFSEY1MXU0RGdscG9tU1BTVjhFNGxPWHM0?=
 =?utf-8?B?WGNOTTZXb3phZFk3dGFQMFZ1NTBobCsrd1BDZ2RMTzJXdUppdVdtbWc5bzFZ?=
 =?utf-8?B?NHVOUUhTWWc5WFRrYVlYZm5tM0k4clVoaE1vakdpSWd4TnRQUWZ0MGpWSTQ0?=
 =?utf-8?B?NFZieExzZlF6cjhueVdXWGlwdldsb2tIWEdqcnp3Y1lIeDZrN1BqOENRbTBV?=
 =?utf-8?B?VUhUQ0RQK0I4SWF4RlU3eTMvSGNlZjdtNk5mMGRwdnNmRkE3S3E5d2UwNVBn?=
 =?utf-8?B?ZkVzNUM1MnQ3R2FqTHFFc3ZFbXpIaGZ5TEw3MGNQYTh4bnVqYkFBM0xtTHN0?=
 =?utf-8?B?L21Pa2h1SmlrYmRWeThFMGxVU1dXeUc2eEtqb0JyRTJoeWoxN1o3S0ZCOXZV?=
 =?utf-8?B?cDByY1J1MlZaN0hmMFZnL3BkQmpQbTJqZVd2Nmp4TE43TEFUeDBiOGsvanRj?=
 =?utf-8?B?U1l5Uk9oeG5qVk1pUEtML0N3TWNQV0phVGdSR0hVV0VvbEkvNE1HUTlpdVpa?=
 =?utf-8?B?U2hUSUxoV2RjQmdtNjRWTW5OL293OGtjcC9PUXZJZ2lsR3dZSFczc0dBYUp2?=
 =?utf-8?B?aGZnTDA2SUp3YXpJazJZT0lEaDJUVlFpZ1Vkdi9pVTFSeHV3dTBzb2NJdThR?=
 =?utf-8?B?cTgxbVQwTGNDU2Zhd2hETDBjejQvenBGUUlmR2JadTc2UW0yZ1FlRGdXWUFX?=
 =?utf-8?B?MjdIcFFpZzYrNFM0UTBuWkdKTUxTYVlqWkpxSStyaTdiL0J0ZkR4NXhIT1BN?=
 =?utf-8?B?VWo2OHhjb1haNjBtc0gvYWNpQlp3aTk0UDlJOE5FUDZtcHNNUyszUEZzVUFC?=
 =?utf-8?B?c1pveVQ1bkpTWXhzWVBlM1JHYmR2WmJPRVNMb2dSUytTSzkraTZscGNaZnNi?=
 =?utf-8?B?TlFjOWJ3R0JXT3h1M1hUR04xSzgyOURoOHhaN3ZHSjF5UnRaSXNtZGJ0UXA4?=
 =?utf-8?B?c2J2bTA2NXJaSis4ZStzckdBakJVemIyUFN0VnNGVU9laFQvVFhyRXpwRnNW?=
 =?utf-8?B?TExvYWJXUmU4U1ZBNFlNc3REQmpscFZmRGlNRS8wL3MyRURzS0F3K1hUL09j?=
 =?utf-8?B?Z3pYZERIY1ZVZVJoTjA0RUJYVXhSMU1VTkhDcGZvQkY3V1R2TlVST01OSWph?=
 =?utf-8?B?MHMwbE1wajJWM0Qxayt5a1IvOHhFb1FkZldrWUp5Y25WOEx6dFB2ZzZwODBy?=
 =?utf-8?B?VmoxM1ovcEpicnM1OHdSa2xOSDRpSjh4b0I3QklVQ29ZOFVoVGhsV095UVd0?=
 =?utf-8?B?eTRlNi9pdmN6WnVtQk9UYmR5dzQweURxak1ROHZGVCtBVUFJZUIzSFdub2lG?=
 =?utf-8?B?dm9JSU5ncFhCK2NsYjhXM2dmN1lPQ1ppT1R5UlkxUnViUHpRQVdZb0pxdVg2?=
 =?utf-8?B?aGF5QlhRUU9zbUFQOHN6SVB4d1BQWFdEeDVhd0kvOXBpbTRONXpLVkN3eEN6?=
 =?utf-8?B?S0NGRlNhbkxZczZzS1N0MTJuTnAwalJaTXQwV2haTHA4UG1LNWhzOUNXSkdS?=
 =?utf-8?B?M2VCOW85ZndvQ3VXaE5Fbm1XcWJtSzJ6MFk1VmpyODVRejdmc1kvV3JyK2Vi?=
 =?utf-8?B?cGxQZ0pFODExdzhVaXNuakNMMUxVVThIcXNmWW9lSExuUTRhNDFYWk1mY2Vs?=
 =?utf-8?B?NHhmU3o1MlllWG1kM1pwQWtCK0k3TDdGVW5hclFkc2plTWJDOUpkeXFLL3k3?=
 =?utf-8?B?SC9OblhDN0dzSFVKcVVMT3A5NHR6NkFRK2s1RERCdWRyQVNES2Q2Z2xmdHJ6?=
 =?utf-8?B?amZ5dkp6NlhKdUJ6M2o1VG1JWjEwVS9Rb2gwNzkrVHUvMlJBdENjWjJ6OERS?=
 =?utf-8?B?UUorQ2d1VnlxSmE1b2Z5VzI2MEdrcjlMUzZNQmR6QnZlVk5VUFZtR0tDMHpm?=
 =?utf-8?B?UHJQLzZiRWhMNy9XdlBCZXpGTldsS3J6VmRIaDNVSWV0R01kQk1qSDdhRGcv?=
 =?utf-8?B?ZVJrNG9oSzNkQlFRODFVSEsvVGFqVVptYXBnU0J3SlkxTnFDU2ZqNGJ2S2I5?=
 =?utf-8?B?MHp1STJQN21LMGdsOC8xN2FYMHBVeGZKaW45ZlpBSDdkeXJRQ0lsZW5Mb0xH?=
 =?utf-8?Q?jf5WFqop04od61iZxXcNPdEqU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f9c869-fb6e-4899-eb00-08de28d5f1a6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 08:14:08.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzRLkXXEvosxQrM77wIsZsKG4nWy6SwDYqNYgyIyGawgx61BRAKZlspG/M1cVYQwmnHIYlIZeLHzc1sGeoq+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

On 11/21/2025 10:51 AM, Jinhui Guo wrote:
> The return type of __modify_irte_ga() is int, but modify_irte_ga()
> treats it as a bool. Casting the int to bool discards the error code.
> 
> To fix the issue, change the type of ret to int in modify_irte_ga().
> 
> Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


