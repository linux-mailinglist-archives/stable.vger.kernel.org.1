Return-Path: <stable+bounces-160390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444F8AFBA37
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669914235AE
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BD22DF9E;
	Mon,  7 Jul 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fTDoxGY2"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB217A586
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911071; cv=fail; b=sjmKV7h1IziSuN1ZkXC4bv+i0qLVnKW0nebmuMfLgwk9Sm52ywZo4CCbGswRzfxCmOyDo3sWOzb3EWIpZuXRMBokDLw72RRVLF3DQx1qecVJC4p3Yg1yfon95QDi4HGjukjYYNlWnOAFLmGR3U+RTkLzBqXBf9TemnEidUo4gjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911071; c=relaxed/simple;
	bh=shdKQ/ee3N1BOQF6V40gawlRQbo8juYEv+UdBsHoa3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YjLBmYa8Dxy7ln4BPXj0mfNTlBB/HVxU16GH3hbeTFTjUKJhFmWZjJ2gmc6i5hr/k8XLMCDBiARvsdQ0MaLm6DVNq6PrfWHm24F/FrVCu5MCovr5cxZp8CDCupJz1zHRF79uxv6Sy6hBQHT/U0TnoYbA5IQ1p75zs0UTyUNUn3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fTDoxGY2; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqG7uETNT8Y4lxKYiCPGjKGAJHRYkKX4R9XOcw+VdQFXMMbZwQdeOpPXi3v6MBLwwbFSx/qWZuy5CjUTtBY50ZTL4HiT21dXinKjKfpA5LiaRZFbhjep+Ht/bcePtz/8g5U5vdLp3puOWIsIThtdMa0V4OLskKSB7MyMCsNezolGxIMUh0ct7sR31bRdKqKi9UB5JAutSx7bKHThFrUr762kC7shmt1o3Pjh+QqxElSlEptgo0VB74KRuwL8UK1k5/8JLAAZS5U05J749rNK+O+bGeqC5wqjpciS3Js7NCDkWYNrRctnH/pIT++pKQRV/cQLEEMhi+pBgSxkRwva9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAfK+VFZElzEx4sMmQyytKKKtb1aJk/0vhccp8t1co4=;
 b=mG2cu/qm3MeuAxCTnQEHV0PnE5mvd9JX82iULqrjdR4yDM6IUCGL115+3h3q/F6YCfSwsmgvkydU2A1V4fYP+nH1DI7Gx8Dv9Fx7EaShoyemGMTNkKUDdRrVqCPJeEsnul6vylZ7V9NVV7yCyJMuTTQdYikYBUbfpDH73audUmD7wrfW+NiuA47Y6m0gELj5g6tO1WA3DC1LcqAmD0NgVl9HrUAnjxF1dPFKF3l21O60m0iQsvdIjUARJkxoLOU8miyUmntwqKziq/d8XUH57bVieSyiZz9tGUXL8W6muV+nlP0L74fFJ6RRsQKCk5laX/E/tS1W6YNDKuQTOmZQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAfK+VFZElzEx4sMmQyytKKKtb1aJk/0vhccp8t1co4=;
 b=fTDoxGY2Ta8qJUFJ9243c+6Qm3Th7xTkRnBrddrraaY3XAZ7J6qKgWDlCcIWoiUlfW7I4q0rqE9GoK60wwQyxY5/PzH51Mvyte2woGSQ/BwiIG3otsolIh+H6nExGK4ZSCpSi+H3OnG8eirwtdx+n4Hks9H87m5YESIyP6vMI3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 17:57:44 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 17:57:44 +0000
Message-ID: <54b5d8af-980c-40c0-bed1-1cb91cfaeb50@amd.com>
Date: Mon, 7 Jul 2025 12:57:39 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6.1.y] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?=
 <zilvinas@natrix.lt>, Borislav Petkov <bp@alien8.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <2025063022-frail-ceremony-f06e@gregkh>
 <20250701171032.2470518-1-avadhut.naik@amd.com>
 <2025070258-panic-unaligned-0dee@gregkh>
 <8b274e68-29e4-436a-9bb1-457653edaa2e@amd.com>
 <2025070319-oyster-unpinned-ec29@gregkh>
 <3d2a2121-4a5d-445f-8db0-8f1850a72769@amd.com>
 <2025070750-lapel-bunkmate-672f@gregkh>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <2025070750-lapel-bunkmate-672f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0136.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::16) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 9656ca26-5c92-4852-dc3b-08ddbd7fc43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVM4ZjRsU2U5aEp1ckloOWNMY2FudWxQVkE4ejVySkhyeFRITjJYTlRpTjNx?=
 =?utf-8?B?WkYxbkhVSEprV2lnb0xJZVl6TFFSNThjTW5SWWJGT3BuNDZybTJiN1dNeE5L?=
 =?utf-8?B?a2RQMHNWdFZmNWI2eEFicldXTFgvSGQ5VEtKdVVRMFQzVC9WaFVhbFFsWVpL?=
 =?utf-8?B?SUxwVUtkYThYb3BRN21ORmFGZmJLaFZRRUdQMjk2L0lxZ0E4SDg0dk5uYmVQ?=
 =?utf-8?B?TGVJOUFRc3ZGUnJVSnorMElFRXo4a3EyR3JDaVpONENxdDN1Z0tLNC9xbDRq?=
 =?utf-8?B?YzFNZFhKL2tqRGlpYllLWmowMnZBTzJ4YjZrR1VRakJLKzlpUGpxYUxJWllN?=
 =?utf-8?B?NzcrWjQxTlhrZDdRSFh2dmUyRDB3M0ExZE55OXk2RmR3RDduMklsVlkveFEr?=
 =?utf-8?B?SHhJTkh2MlkvdUVNOUhxM0VCczRjTE5kUUNWTFNOTzhIMG5FUkM5eUx4Yzcw?=
 =?utf-8?B?blhkdnp6L2FZdTdqYmFKbzBROE84ejA0eGVtVUNiczJqTEk4U2pBMjR1Z1c2?=
 =?utf-8?B?OHhMMGw0WnNFOGJkWURCemVIRlRibzEzTDEzQXRibDgrZGxJMDc2bHNsbTVz?=
 =?utf-8?B?cVRHVTE3RTJBcG9KTnRRUXVNZ1gxcnZ4SWhTZnVlRzFRSStEK0ord0tDcWdS?=
 =?utf-8?B?Vk5HK21ycWZseFVvcnNYZEdneW1FUjh2U01CMTlXZTVoVFBlZENNR1drMmty?=
 =?utf-8?B?dEJldVdDN3IxWjZOKy80dzVCNGlpcng0cytQU25ZZ2hEdGRycVBLYjNyVlVV?=
 =?utf-8?B?VW93TWp4RlhrT1pOWTdOd0MyTFByem5Nak1LcUJyby9CSkJTejRWWFpzWXVj?=
 =?utf-8?B?bjJNaFNDcXRHaDloZGU1WkFQM0p6VTU4aGFOc25jeVl1UXg1UlE4TGhBNWJF?=
 =?utf-8?B?U1lkR1Rva3BFM2JVRDBqRjJjQnBZdWU5U2pxNFpUUTY0Y25ubzlIbS9VV3Nz?=
 =?utf-8?B?R2VlQjBSOTFsZHdvN05BQ01kUzdMVnN4Z2JmK1QyNG5UQ1g4WmJwb2RwQzFt?=
 =?utf-8?B?em00ZEIzNlRsbVdhSncvNVFzS3BoZ21FaUZvTFRYLzJOeXRXcHNyV3Jxa3l4?=
 =?utf-8?B?M1hYVG9IUVZlUUJqcXFJY0xLYnUwZExBTHJBYytHSElpQUwwQlZxYUwweGIx?=
 =?utf-8?B?d3FOb1h5cWh6aEJMdzBuZUlnVEZ5d1dvL1VPWkwwcDFURVpSTFFnZTdFcXlQ?=
 =?utf-8?B?S3o5MXdZMm13VXpCNExnNjZ5OE9oUE5yZlRnMlVyY0FEc0wrQ1JYZ3IwTU0z?=
 =?utf-8?B?RnVPRGM0cjg3UzVUQ2d6Yjl6ZkFrcStSOGV4RDFXRC9nV0l6RnJqTUxpVkhZ?=
 =?utf-8?B?enBjWFR6c2RnVllGVVlJdHBTbFU0L3Vqa1R1S2J0TURmYVF4WGFUN3hhMmE5?=
 =?utf-8?B?eXFRYjBYYno0cThkRjhwNlU5VjRrSFluOVpoSVJIZnlnaWZ3TGs5d1Z3WFlP?=
 =?utf-8?B?OHJyQ2h2bldYWGc3dWVwS2hEVXdTVEdYd0RxZnlJZjJWbURMWWx3ZG0wQUh6?=
 =?utf-8?B?bTBsNFZQWCs5dUROTzUrdmQ3bTZtL1ZFR1lsODNJYmtqTFM2bjhIYkVHbTVU?=
 =?utf-8?B?cUxLMk5hejhST2JMRkF4UGFsSm5WMHdPL2ZjNHh3RldUL3prUFk3RmJwcU15?=
 =?utf-8?B?R2RBSSttQXU5am1tUEdKZWNIZWhYTGE3ejE3bHQ3aE5PZGlkVGFIWWZQZGlY?=
 =?utf-8?B?Um12NCtlUWhCSzdnc3AwajQzejdFUkp4TEZJRGEyWElnVnZlSEFvNm4yVHhH?=
 =?utf-8?B?REV3cUtXcE9HcCtScGZlQ29ma3FYeHdsRllhTG01eG1oKytLaExadUMwT3VU?=
 =?utf-8?B?ZVU0RHZCeVQ2cFd3bVo0aU9VdzYyLzRCY2pVQjh1dXlXcDBFMml4MmxyZWc3?=
 =?utf-8?B?UElvQkVvaS9IUzBpUkhwZks1Yk9PQXg4M1N6Uk55UHc1b2FiRzVyTVVZWENV?=
 =?utf-8?Q?8tBWtYi8REs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtiQ1E2VHBBZ3F5dE91cGQrMTFDcEZRYmV0ZnpybkRKa3pZWUtGUy9rTGFF?=
 =?utf-8?B?b1R2Z1crQndvOGd0VGd5Z0tPeUcrRnNCT3FkZTM5bDZIT0MzUURqMFMzelVL?=
 =?utf-8?B?ZVltc2xTYkFxZmJra2JOckp0QTVDR3d4eDIrYWpzdDI3bjE0NE9xVWZURkZv?=
 =?utf-8?B?VEY1SkkxWk9jSVQwNTl1bm5tS2d4TzlaeGl0MUVpd3lYRFAvZ21US1FiRmNy?=
 =?utf-8?B?WlNBSEVNYUdrbTl5MEUyNjVyZjJCRk5TRDgzUGQyM0M3UGp0ZUFUcEFWK1pn?=
 =?utf-8?B?a1BNdXA5YnRGOHZaK1NXNUZxY0pPYlBubng2UklXdE5wQWhLeTNVVVlJSklp?=
 =?utf-8?B?bUp4OUluY24vVzFIbk5sNmFyZ0gvczVvZ1NWb1MvaWVVelVUL3YzN29FL1lx?=
 =?utf-8?B?UTRxNkhFUTV2RFRiWVRNYi9ubkVXYkNiMFh3MHg2Z29adFhJa1pZdUFWNkxv?=
 =?utf-8?B?NmdqTkNOQ1dSUjFyQmtJWDU3N082Vng2ZWtvOWFqVEc4YnNla2FwZnlraUF2?=
 =?utf-8?B?aEhiTUJ0aGhKcVVXTmEwMm1adGhyZGpYWlcyMkZkUEkvZFlHcTM2K3hJbkJw?=
 =?utf-8?B?dGx1NUhEa3c0ZWVXd3VCZ2l5dUdaL3ZyL1ZsMFN3cjhUNnQxT01NTUE0Qy9K?=
 =?utf-8?B?NGNZUDJwUUExQ1FNS0JpaXRxRjJpRFg5NFBCYmZzLzJ6ZmRwRWpaTGJBTTNj?=
 =?utf-8?B?Uk5SWGVlRitxODV2RzZ3cS9yL1NhNUsxZU94bGZ3VEx1OExSMm8ySzZBeFEy?=
 =?utf-8?B?Qkg4S2hjeThDWWd2b3h1ZTNtOTBQL0p6SGdDQjJxZUVoUkJnREtoK2E2Vng3?=
 =?utf-8?B?WDFaWmwrRzlHSXoyZy9ZRTY2dm1GaEZlU29yTUdDM0phYlYxR29SQloycGxo?=
 =?utf-8?B?OU1jaGJteE9PSUV6UUkySk9Nem9IaVloNnhJTmVDcSswK0F1REgzTTg2Tm9P?=
 =?utf-8?B?eGErbHhMa1V3dHlMSURudTNYWHVaMXhwYzVFb09KMUhzK0hOTERHRlRHQnN5?=
 =?utf-8?B?Wkk2UEdmTExwNWtUWTJySGhJaWh6eE1lYzdpNGR6SUVwZytvVDg4eG5vYTM2?=
 =?utf-8?B?d2RadktmTEZ2NlpqTUh0TGkxRmhrTW5iSnU3T1NRWTJTaURkL042RzkwYXg0?=
 =?utf-8?B?cjRCYm43Nm5abXN0S1dIN2lLUDF2ek5TYkNYWW0ycEx0L2dPVnNqTXh3RGRM?=
 =?utf-8?B?aEo1MVlZUlFEU21mMXZxRTNmbkFXZDZna25CSDlCVGNmNHllN01IOWFRbVk2?=
 =?utf-8?B?OW16TE9FdHh3SHZyWkgrUXpETzFhbnRTWnZQdlVwbUUzZmRNcG5PRDJnR3Np?=
 =?utf-8?B?ZHl0RFROOWlJWllpdUFJRVF5ajRpNjJndWRCTjJPNVJ3VDhsdmZDYU9DSUcv?=
 =?utf-8?B?TXN6SGxkK2ZMUXVzVlA5VkpISkhiNFViOHVyaUtlaG9zYmFadmU4aXZnUjAr?=
 =?utf-8?B?SkNKNTR3VTlQazZJRGJqekRyYzJJajRnaGtkTGl0SVl1KzJOSU5SSitXV0s2?=
 =?utf-8?B?SWU2cjVaODNzeldoQmhWczh6WXFiRFFCVjFhUWlPdkNORkxOUTBUUmdFYW5w?=
 =?utf-8?B?QXlCOEQ0a2h4alFKczVSS0F2SWhQNVdHMmVDUGNnbnNvQzZnRGlkbE81d05M?=
 =?utf-8?B?UGhnZTA1R3c0eEViT1EzTTJSSVNyNGV1cG1xcUtBTXAwRjMwUkNaRGVJZngx?=
 =?utf-8?B?dHJBMHZxNmc0YmJoMHVjeE5QdXo1NFgrOVJwNERoNFRnU1JiaEFhaXJ1eFdi?=
 =?utf-8?B?QUVEdU1LdmEvaG9zR2hxNjllNXpZL0NLOG5oMUZKZUpaUWRLVUpjRWU0OHcy?=
 =?utf-8?B?MExiQnVsVTFhdTBVMkRJOWlnTzJRQUtYbCs2WFB4YWdHblFtUTB3YjhaZzB1?=
 =?utf-8?B?Q21GOWo5VGpKTGJHMnUyZnU1cGR1R1BiTmFCUXFRWkoxSnNESVBQcUhGUXFp?=
 =?utf-8?B?VSt0blpFWEJxenZXdHVBRDcydTFtSjJ0OC9MOTZvblRWVUo3TklxdTdHSW9s?=
 =?utf-8?B?VTFwTXFqVitoaE03bGhQY1E0cTV4aG1EdDg2MGVJUjN2a09PWWoxOWpYanZJ?=
 =?utf-8?B?NVR2b3JPQkpMaFB6dUhUU1hFTFN6L3ZiVkZRTE1BMWN0MmcwYWdLdUQxV3Ju?=
 =?utf-8?Q?7BkDg6LcxMIkf9ucFYaVMQYNI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9656ca26-5c92-4852-dc3b-08ddbd7fc43d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 17:57:43.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aas9vi9GMNm09CXrbzZ3ghHkSStmHkLHp2JWUyPtLe+5+IAE5/37qnGlLKTCilt1eg/zkIlr9+xqoQ6puhE4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067



On 7/7/2025 02:44, Greg KH wrote:
> On Mon, Jul 07, 2025 at 02:00:24AM -0500, Naik, Avadhut wrote:
>>
>>
>> On 7/3/2025 00:28, Greg KH wrote:
>>> On Wed, Jul 02, 2025 at 12:19:41PM -0500, Naik, Avadhut wrote:
>>>> Hi,
>>>>
>>>> On 7/2/2025 09:31, Greg KH wrote:
>>>>> On Tue, Jul 01, 2025 at 05:10:32PM +0000, Avadhut Naik wrote:
>>>>>> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD Zen-based
>>>>>> SOCs has an Address Mask and a Secondary Address Mask register associated with
>>>>>> it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS granularity
>>>>>> during init using these two registers.
>>>>>>
>>>>>> Currently, the module primarily considers only the Address Mask register for
>>>>>> computing DIMM sizes. The Secondary Address Mask register is only considered
>>>>>> for odd CS. Additionally, if it has been considered, the Address Mask register
>>>>>> is ignored altogether for that CS. For power-of-two DIMMs i.e. DIMMs whose
>>>>>> total capacity is a power of two (32GB, 64GB, etc), this is not an issue
>>>>>> since only the Address Mask register is used.
>>>>>>
>>>>>> For non-power-of-two DIMMs i.e., DIMMs whose total capacity is not a power of
>>>>>> two (48GB, 96GB, etc), however, the Secondary Address Mask register is used
>>>>>> in conjunction with the Address Mask register. However, since the module only
>>>>>> considers either of the two registers for a CS, the size computed by the
>>>>>> module is incorrect. The Secondary Address Mask register is not considered for
>>>>>> even CS, and the Address Mask register is not considered for odd CS.
>>>>>>
>>>>>> Introduce a new helper function so that both Address Mask and Secondary
>>>>>> Address Mask registers are considered, when valid, for computing DIMM sizes.
>>>>>> Furthermore, also rename some variables for greater clarity.
>>>>>>
>>>>>> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
>>>>>> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
>>>>>> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
>>>>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>>>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>>>>>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>>>> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Link: https://lore.kernel.org/20250529205013.403450-1-avadhut.naik@amd.com
>>>>>> (cherry picked from commit a3f3040657417aeadb9622c629d4a0c2693a0f93)
>>>>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>>>>
>>>>> This was not a clean cherry-pick at all.  Please document what you did
>>>>> differently from the original commit please.
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>
>>>> Yes, the cherry-pick was not clean, but the core logic of changes between
>>>> the original commit and the cherry-picked commit remains the same.
>>>>
>>>> The amd64_edac module has been reworked quite a lot in the last year or
>>>> two. Support has also been introduced for new SOC families and models.
>>>> This rework and support, predominantly undertaken through the below
>>>> commits, is missing in 6.1 kernel.
>>>>
>>>> 9c42edd571aa EDAC/amd64: Add support for AMD heterogeneous Family 19h Model 30h-3Fh
>>>> ed623d55eef4 EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
>>>> a2e59ab8e933 EDAC/amd64: Drop dbam_to_cs() for Family 17h and later
>>>
>>> Why not take these as prerequisite changes?  Taking changes that are
>>> radically different from what is upstream is almost always wrong, it
>>> makes future backports impossible, and usually is buggy.
>>>
>> Just to ensure that I have understood correctly, are you suggesting
>> that we backport the above three commits to 6.1 too?
> 
> Yes, why not?

I just mentioned the above commits because I think they modify the code
in question for this backport.
But these commits have been merged in as part of larger patchsets (links
below):

9c42edd571aa: https://lore.kernel.org/all/20230515113537.1052146-5-muralimk@amd.com/
ed623d55eef4: https://lore.kernel.org/all/20230127170419.1824692-11-yazen.ghannam@amd.com/
a2e59ab8e933: https://lore.kernel.org/all/20230127170419.1824692-9-yazen.ghannam@amd.com/

Backporting these commits might require us to backport these entire
sets to 6.1.
Wasn't completely sure if this is the road we want to take.
Hence, asked the question in my earlier mail.

-- 
Thanks,
Avadhut Naik


